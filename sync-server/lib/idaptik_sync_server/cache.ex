# SPDX-License-Identifier: PMPL-1.0-or-later
# Copyright (c) 2026 Joshua B. Jewell and Jonathan D.A. Jewell
defmodule IDApixiTIK.SyncServer.Cache do
  @moduledoc """
  In-process ETS-backed cache for level data.

  Replaces the previous Dragonfly/Redis external cache with a zero-dependency
  ETS table. ETS is built into the BEAM, runs in-process with zero network
  latency, and supports concurrent reads. For an indie game sync server this
  is more than sufficient.

  The GameSessionRegistry handles durable persistence via DETS. This cache
  is purely for fast lookups during a running session — data here is ephemeral
  and reconstructed from GameStore's Agent state on cache miss.
  """
  use GenServer

  @table :idaptik_level_cache

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  # Satisfy the Supervisor child_spec interface so Application.ex can
  # list this module directly in the children list (same as before).
  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent
    }
  end

  @impl true
  def init(_opts) do
    # Create ETS table: named, public reads, set (key-value), concurrent reads.
    :ets.new(@table, [:named_table, :set, :public, read_concurrency: true])
    {:ok, %{}}
  end

  @doc "Cache a level by its ID. Overwrites any existing entry."
  def set_level(id, data) do
    :ets.insert(@table, {"level:#{id}", data})
    :ok
  end

  @doc "Retrieve a cached level by ID. Returns nil on cache miss."
  def get_level(id) do
    case :ets.lookup(@table, "level:#{id}") do
      [{_key, data}] -> data
      [] -> nil
    end
  end

  @doc "Remove a level from the cache."
  def delete_level(id) do
    :ets.delete(@table, "level:#{id}")
    :ok
  end

  @doc "Clear the entire cache."
  def clear do
    :ets.delete_all_objects(@table)
    :ok
  end
end
