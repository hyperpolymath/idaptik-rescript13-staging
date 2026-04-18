# SPDX-License-Identifier: PMPL-1.0-or-later
# Copyright (c) 2026 Joshua B. Jewell and Jonathan D.A. Jewell
defmodule IDApixiTIK.SyncServer.LevelChannel do
  use Phoenix.Channel
  require Logger

  def join("level:" <> level_id, _payload, socket) do
    Logger.info("User joined level #{level_id}")
    # Load initial state from GameStore
    case IDApixiTIK.SyncServer.GameStore.get_level(level_id) do
      nil -> {:ok, socket}
      data -> {:ok, data, socket}
    end
  end

  # Handle real-time architectural changes
  def handle_in("update", payload, socket) do
    level_id = String.replace(socket.topic, "level:", "")
    IDApixiTIK.SyncServer.GameStore.update_level(level_id, payload)
    
    # Broadcast to ALL other designers
    broadcast_from!(socket, "sync", payload)
    {:noreply, socket}
  end

  # Handle presence (Mouse movement / Ghost shadows)
  def handle_in("presence", payload, socket) do
    broadcast_from!(socket, "ghost", payload)
    {:noreply, socket}
  end
end
