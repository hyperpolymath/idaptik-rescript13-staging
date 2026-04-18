# SPDX-License-Identifier: PMPL-1.0-or-later
# Copyright (c) 2026 Joshua B. Jewell and Jonathan D.A. Jewell
defmodule IDApixiTIK.SyncServer.GameStore do
  @moduledoc """
  Global source of truth for level data during a sync server session.

  Uses an in-process Agent for authoritative state and the ETS-backed Cache
  module for fast concurrent reads. No external dependencies — everything
  runs inside the BEAM.

  For durable persistence across server restarts, see GameSessionRegistry
  which uses DETS.
  """
  use Agent
  alias IDApixiTIK.SyncServer.Cache

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @doc "Store or update a level. Writes to both Agent state and ETS cache."
  def update_level(level_id, data) do
    Agent.update(__MODULE__, &Map.put(&1, level_id, data))
    Cache.set_level(level_id, data)
  end

  @doc """
  Retrieve a level by ID.

  Checks ETS cache first (concurrent, zero-contention reads), falls back
  to Agent state on cache miss.
  """
  def get_level(level_id) do
    case Cache.get_level(level_id) do
      nil -> Agent.get(__MODULE__, &Map.get(&1, level_id))
      data -> data
    end
  end

  @doc "Remove a level from both Agent state and cache."
  def delete_level(level_id) do
    Agent.update(__MODULE__, &Map.delete(&1, level_id))
    Cache.delete_level(level_id)
  end

  @doc "List all level IDs currently in the store."
  def list_levels do
    Agent.get(__MODULE__, &Map.keys/1)
  end
end
