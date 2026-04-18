# SPDX-License-Identifier: PMPL-1.0-or-later
# Copyright (c) 2026 Joshua B. Jewell and Jonathan D.A. Jewell
defmodule IDApixiTIK.SyncServerWeb.UserSocket do
  use Phoenix.Socket

  # Level editor collaboration (Tauri desktop app)
  channel "level:*", IDApixiTIK.SyncServer.LevelChannel

  # Main game multiplayer (browser client)
  channel "game:*", IDApixiTIK.SyncServer.GameChannel

  @impl true
  def connect(params, socket, _connect_info) do
    # Extract player identity from connection params (if provided)
    player_id = Map.get(params, "player_id", "anon_#{:rand.uniform(99999)}")
    {:ok, assign(socket, :player_id, player_id)}
  end

  @impl true
  def id(socket), do: "user:#{socket.assigns.player_id}"
end
