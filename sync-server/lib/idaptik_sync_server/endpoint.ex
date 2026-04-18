# SPDX-License-Identifier: PMPL-1.0-or-later
# Copyright (c) 2026 Joshua B. Jewell and Jonathan D.A. Jewell
defmodule IDApixiTIK.SyncServerWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :idaptik_sync_server

  # WebSocket transport for Phoenix Channels
  # Clients connect to ws://host:4000/socket/websocket
  socket "/socket", IDApixiTIK.SyncServerWeb.UserSocket,
    websocket: [
      timeout: 45_000,
      check_origin: false  # Allow browser connections from any origin (dev)
    ],
    longpoll: false

  # JSON parsing for REST endpoints
  plug Plug.Parsers,
    parsers: [:json],
    pass: ["*/*"],
    json_decoder: Jason

  # REST API router
  plug IDApixiTIK.SyncServer.Router
end
