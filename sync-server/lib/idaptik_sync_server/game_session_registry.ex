# SPDX-License-Identifier: PMPL-1.0-or-later
# Copyright (c) 2026 Joshua B. Jewell and Jonathan D.A. Jewell
defmodule IDApixiTIK.SyncServer.GameSessionRegistry do
  @moduledoc """
  Tracks active game sessions and their players, with DETS-backed persistence
  so sessions survive server restarts.

  Each session has:
  - A unique session ID (generated or user-provided)
  - Up to 2 players (hacker + observer for co-op)
  - Per-device VM state snapshots (for reconnection)
  - Session metadata (level, start time, alert level)

  ## Persistence

  Sessions are flushed to a DETS table after every mutation. On startup the
  table is reopened and all previously active sessions are restored. The DETS
  file path is read from the `:session_dets_path` application env key (set via
  the `SESSION_DETS_PATH` OS environment variable in releases/config).

  Default path: `/app/data/sessions.dets` (container) or
                `/tmp/idaptik_dev_sessions.dets` (development).
  """
  use GenServer
  require Logger

  # DETS table name (atom) used as the named table reference.
  @table :idaptik_sessions

  # Key under which the entire sessions map is stored in DETS.
  @dets_key :all_sessions

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  # ---------------------------------------------------------------------------
  # Public API
  # ---------------------------------------------------------------------------

  @doc "Create or join a game session. Returns {:ok, session} or {:error, reason}."
  def join_session(session_id, player_id, role) do
    GenServer.call(__MODULE__, {:join, session_id, player_id, role})
  end

  @doc "Remove a player from a session."
  def leave_session(session_id, player_id) do
    GenServer.cast(__MODULE__, {:leave, session_id, player_id})
  end

  @doc "Store a VM state snapshot for a device in the session."
  def update_vm_state(session_id, device_id, vm_state) do
    GenServer.cast(__MODULE__, {:update_vm, session_id, device_id, vm_state})
  end

  @doc "Get session info (or nil if not found)."
  def get_session(session_id) do
    GenServer.call(__MODULE__, {:get, session_id})
  end

  @doc "List all active sessions."
  def list_sessions do
    GenServer.call(__MODULE__, :list)
  end

  # ---------------------------------------------------------------------------
  # GenServer callbacks
  # ---------------------------------------------------------------------------

  @impl true
  def init(_opts) do
    dets_path = dets_file_path()

    # Ensure the parent directory exists (handles /app/data/ in containers).
    :ok = File.mkdir_p!(Path.dirname(dets_path))

    # Open (or create) the DETS table. charlist path required by :dets.
    {:ok, @table} = :dets.open_file(@table, [{:file, to_charlist(dets_path)}, {:type, :set}])

    # Restore persisted sessions from previous run, if any.
    sessions =
      case :dets.lookup(@table, @dets_key) do
        [{@dets_key, saved}] ->
          Logger.info("GameSessionRegistry: restored #{map_size(saved)} sessions from #{dets_path}")
          saved

        _ ->
          Logger.info("GameSessionRegistry: no persisted sessions found at #{dets_path}")
          %{}
      end

    {:ok, %{sessions: sessions}}
  end

  @impl true
  def handle_call({:join, session_id, player_id, role}, _from, state) do
    session = Map.get(state.sessions, session_id, new_session(session_id))

    cond do
      # Player already in session — allow rejoin without consuming a slot
      Map.has_key?(session.players, player_id) ->
        {:reply, {:ok, session}, state}

      # Session full (2 players max for co-op)
      map_size(session.players) >= 2 ->
        {:reply, {:error, "session_full"}, state}

      true ->
        updated_players =
          Map.put(session.players, player_id, %{
            role: role,
            joined_at: System.system_time(:millisecond)
          })

        updated_session = %{session | players: updated_players}
        new_sessions = Map.put(state.sessions, session_id, updated_session)

        Logger.info(
          "Session #{session_id}: #{player_id} joined as #{role} " <>
            "(#{map_size(updated_players)} players)"
        )

        persist(new_sessions)
        {:reply, {:ok, updated_session}, %{state | sessions: new_sessions}}
    end
  end

  @impl true
  def handle_call({:get, session_id}, _from, state) do
    {:reply, Map.get(state.sessions, session_id), state}
  end

  @impl true
  def handle_call(:list, _from, state) do
    summaries =
      Enum.map(state.sessions, fn {id, session} ->
        %{
          id: id,
          player_count: map_size(session.players),
          players: Map.keys(session.players),
          created_at: session.created_at
        }
      end)

    {:reply, summaries, state}
  end

  @impl true
  def handle_cast({:leave, session_id, player_id}, state) do
    case Map.get(state.sessions, session_id) do
      nil ->
        {:noreply, state}

      session ->
        updated_players = Map.delete(session.players, player_id)

        Logger.info(
          "Session #{session_id}: #{player_id} left (#{map_size(updated_players)} players)"
        )

        updated_session = %{session | players: updated_players}
        new_sessions = Map.put(state.sessions, session_id, updated_session)

        if map_size(updated_players) == 0 do
          # Last player left — schedule cleanup after a grace period so a
          # quick reconnect can still find the session intact.
          Logger.info("Session #{session_id}: empty, scheduling cleanup in 60s")
          Process.send_after(self(), {:cleanup, session_id}, 60_000)
        end

        persist(new_sessions)
        {:noreply, %{state | sessions: new_sessions}}
    end
  end

  @impl true
  def handle_cast({:update_vm, session_id, device_id, vm_state}, state) do
    case Map.get(state.sessions, session_id) do
      nil ->
        {:noreply, state}

      session ->
        updated_vm_states = Map.put(session.vm_states, device_id, vm_state)
        updated_session = %{session | vm_states: updated_vm_states}
        new_sessions = Map.put(state.sessions, session_id, updated_session)
        persist(new_sessions)
        {:noreply, %{state | sessions: new_sessions}}
    end
  end

  @impl true
  def handle_info({:cleanup, session_id}, state) do
    case Map.get(state.sessions, session_id) do
      nil ->
        {:noreply, state}

      session ->
        if map_size(session.players) == 0 do
          Logger.info("Session #{session_id}: cleaned up (empty for 60s)")
          new_sessions = Map.delete(state.sessions, session_id)
          persist(new_sessions)
          {:noreply, %{state | sessions: new_sessions}}
        else
          {:noreply, state}
        end
    end
  end

  @impl true
  def terminate(_reason, _state) do
    # Flush and close the DETS table cleanly on shutdown.
    :dets.sync(@table)
    :dets.close(@table)
    :ok
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  # Persist the entire sessions map to DETS. Cheap for typical session counts
  # (<100 active sessions in a dev/indie game context).
  defp persist(sessions) do
    :ok = :dets.insert(@table, {@dets_key, sessions})
    :ok = :dets.sync(@table)
  end

  defp new_session(session_id) do
    %{
      id: session_id,
      players: %{},
      vm_states: %{},
      created_at: System.system_time(:millisecond)
    }
  end

  defp dets_file_path do
    # Runtime env var takes precedence (set in container via podman-compose).
    # Falls back to application config, then to a sensible default.
    System.get_env("SESSION_DETS_PATH") ||
      Application.get_env(:idaptik_sync_server, :session_dets_path) ||
      "/tmp/idaptik_dev_sessions.dets"
  end
end
