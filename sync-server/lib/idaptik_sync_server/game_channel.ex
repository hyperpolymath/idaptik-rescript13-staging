# SPDX-License-Identifier: PMPL-1.0-or-later
# Copyright (c) 2026 Joshua B. Jewell and Jonathan D.A. Jewell
defmodule IDApixiTIK.SyncServer.GameChannel do
  @moduledoc """
  Phoenix Channel for main-game multiplayer sessions.

  Topics: "game:<session_id>"

  Handles:
  - Co-op player joining/leaving with role assignment (hacker/observer)
  - Real-time player position sync (platformer coordinates)
  - VM instruction relay (one player's actions broadcast to partner)
  - VM state synchronisation (full state snapshot on join)
  - Bebop connection discovery sharing
  - Device interaction notifications
  - In-game chat between co-op partners
  - Competitive undo relay (attacker vs defender VMs)
  """
  use Phoenix.Channel
  require Logger

  alias IDApixiTIK.SyncServer.GameSessionRegistry

  # --- Join ---

  def join("game:" <> session_id, %{"player_id" => player_id, "role" => role}, socket) do
    Logger.info("Player #{player_id} (#{role}) joining game session #{session_id}")

    # Register player in session
    case GameSessionRegistry.join_session(session_id, player_id, role) do
      {:ok, session} ->
        socket = socket
          |> assign(:session_id, session_id)
          |> assign(:player_id, player_id)
          |> assign(:role, role)
          # Stash session for use in after_join — broadcast_from!/3 cannot be
          # called inside join/3 (socket has not fully joined yet).
          |> assign(:session_at_join, session)

        # Defer the broadcast until the socket is marked as joined.
        send(self(), :after_join)

        {:ok, %{session: session}, socket}

      {:error, reason} ->
        {:error, %{reason: reason}}
    end
  end

  # Fires after join/3 has returned and the socket is fully joined.
  def handle_info(:after_join, socket) do
    session = socket.assigns.session_at_join
    broadcast_from!(socket, "player:joined", %{
      player_id: socket.assigns.player_id,
      role: socket.assigns.role,
      player_count: map_size(session.players)
    })
    {:noreply, socket}
  end

  def join("game:" <> _session_id, _params, _socket) do
    {:error, %{reason: "missing player_id and role"}}
  end

  # --- Player position (high frequency, no persistence) ---

  def handle_in("position", %{"x" => x, "y" => y}, socket) do
    broadcast_from!(socket, "position", %{
      player_id: socket.assigns.player_id,
      x: x,
      y: y
    })
    {:noreply, socket}
  end

  # --- VM instruction execution (relay to co-op partner) ---

  def handle_in("vm:execute", %{"instruction" => instruction, "device_id" => device_id} = payload, socket) do
    broadcast_from!(socket, "vm:execute", %{
      player_id: socket.assigns.player_id,
      instruction: instruction,
      device_id: device_id,
      args: Map.get(payload, "args", [])
    })
    {:noreply, socket}
  end

  # --- VM undo (relay to co-op partner) ---

  def handle_in("vm:undo", %{"device_id" => device_id}, socket) do
    broadcast_from!(socket, "vm:undo", %{
      player_id: socket.assigns.player_id,
      device_id: device_id
    })
    {:noreply, socket}
  end

  # --- VM state sync (full snapshot for reconnection) ---

  def handle_in("vm:state", %{"device_id" => device_id, "state" => vm_state}, socket) do
    # Store in session for late joiners
    GameSessionRegistry.update_vm_state(
      socket.assigns.session_id,
      device_id,
      vm_state
    )

    broadcast_from!(socket, "vm:state", %{
      player_id: socket.assigns.player_id,
      device_id: device_id,
      state: vm_state
    })
    {:noreply, socket}
  end

  # --- Request full state sync (on reconnect) ---

  def handle_in("vm:sync_request", %{"device_id" => device_id}, socket) do
    broadcast_from!(socket, "vm:sync_request", %{
      player_id: socket.assigns.player_id,
      device_id: device_id
    })
    {:noreply, socket}
  end

  # --- Bebop connection discovery ---

  def handle_in("bebop:discovered", %{"connection_id" => conn_id}, socket) do
    broadcast_from!(socket, "bebop:discovered", %{
      player_id: socket.assigns.player_id,
      connection_id: conn_id
    })
    {:noreply, socket}
  end

  def handle_in("bebop:activated", %{"connection_id" => conn_id}, socket) do
    broadcast_from!(socket, "bebop:activated", %{
      player_id: socket.assigns.player_id,
      connection_id: conn_id
    })
    {:noreply, socket}
  end

  # --- Co-op bebop activation request (requires both players) ---

  def handle_in("bebop:coop_request", %{"connection_id" => conn_id}, socket) do
    broadcast_from!(socket, "bebop:coop_request", %{
      player_id: socket.assigns.player_id,
      connection_id: conn_id
    })
    {:noreply, socket}
  end

  def handle_in("bebop:coop_accept", %{"connection_id" => conn_id}, socket) do
    # Both players agreed — broadcast activation to all
    broadcast!(socket, "bebop:activated", %{
      player_id: "coop",
      connection_id: conn_id
    })
    {:noreply, socket}
  end

  # --- Device interaction notifications ---

  def handle_in("device:accessed", %{"device_id" => device_id}, socket) do
    broadcast_from!(socket, "device:accessed", %{
      player_id: socket.assigns.player_id,
      device_id: device_id
    })
    {:noreply, socket}
  end

  def handle_in("device:locked", %{"device_id" => device_id, "reason" => reason}, socket) do
    broadcast_from!(socket, "device:locked", %{
      player_id: socket.assigns.player_id,
      device_id: device_id,
      reason: reason
    })
    {:noreply, socket}
  end

  # --- Chat ---

  def handle_in("chat", %{"message" => message}, socket) do
    broadcast_from!(socket, "chat", %{
      player_id: socket.assigns.player_id,
      message: message,
      timestamp: System.system_time(:millisecond)
    })
    {:noreply, socket}
  end

  # --- Alert level changes (guard detection) ---

  def handle_in("alert:changed", %{"level" => level}, socket) do
    broadcast_from!(socket, "alert:changed", %{
      player_id: socket.assigns.player_id,
      level: level
    })
    {:noreply, socket}
  end

  # --- Competitive undo (attacker vs defender) ---

  def handle_in("competitive:undo_challenge", %{"device_id" => device_id, "instruction" => instr}, socket) do
    broadcast_from!(socket, "competitive:undo_challenge", %{
      player_id: socket.assigns.player_id,
      device_id: device_id,
      instruction: instr
    })
    {:noreply, socket}
  end

  # --- Disconnect ---

  def terminate(_reason, socket) do
    session_id = socket.assigns[:session_id]
    player_id = socket.assigns[:player_id]

    if session_id && player_id do
      GameSessionRegistry.leave_session(session_id, player_id)

      broadcast_from!(socket, "player:left", %{
        player_id: player_id
      })
    end

    :ok
  end
end
