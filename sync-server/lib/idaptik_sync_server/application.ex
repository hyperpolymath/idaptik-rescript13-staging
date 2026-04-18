# SPDX-License-Identifier: PMPL-1.0-or-later
# Copyright (c) 2026 Joshua B. Jewell and Jonathan D.A. Jewell
defmodule IDApixiTIK.SyncServer.Application do
  use Application

  @impl true
  def start(_type, _args) do
    topologies = [idaptik: [strategy: Cluster.Strategy.Gossip]]

    children = [
      {Cluster.Supervisor, [topologies, [name: IDApixiTIK.SyncServer.ClusterSupervisor]]},
      {Phoenix.PubSub, name: IDApixiTIK.SyncServer.PubSub},
      IDApixiTIK.SyncServer.Cache,
      {Horde.Registry, [name: IDApixiTIK.SyncServer.Registry, keys: :unique, members: :auto]},
      {Horde.DynamicSupervisor, [name: IDApixiTIK.SyncServer.DistributedSupervisor, strategy: :one_for_one, members: :auto]},

      # Game session and state management
      IDApixiTIK.SyncServer.GameStore,
      IDApixiTIK.SyncServer.GameSessionRegistry,

      # Database federation bridge — ArangoDB (game) + VerisimDB (levels)
      # Must start after Cache (uses ETS) but before Endpoint (serves requests).
      # Starts in degraded mode if either database is unavailable.
      IDApixiTIK.SyncServer.DatabaseBridge,

      # Phoenix Endpoint — serves WebSocket (channels) + REST API
      IDApixiTIK.SyncServerWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: IDApixiTIK.SyncServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
