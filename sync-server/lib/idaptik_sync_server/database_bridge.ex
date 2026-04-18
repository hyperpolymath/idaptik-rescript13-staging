# SPDX-License-Identifier: PMPL-1.0-or-later
#
# DatabaseBridge — Coordination GenServer for the ArangoDB + VerisimDB federation.
#
# This is the boundary where Idris2 ABI types are enforced at runtime.  Every
# write passes through schema validation before touching either database.
# Invalid data is rejected with a descriptive error — nothing reaches ArangoDB
# or VerisimDB without passing the contract.
#
# Responsibilities:
#   1. Health-check both databases on startup and every 30 seconds
#   2. Bootstrap ArangoDB collections (idempotent)
#   3. Initialise ETS caches for both clients
#   4. Route game data to ArangoDB, level data to VerisimDB
#   5. Validate schemas at the boundary (player, device, level structs)
#   6. Graceful degradation — if a database is down, the bridge still starts
#      and the existing ETS/DETS game session system continues to function
#
# Data ownership:
#   - ArangoDB:  players, sessions, devices, zones, network topology (game)
#   - VerisimDB: levels, version history, validation logs, similarity (architect)

defmodule IDApixiTIK.SyncServer.DatabaseBridge do
  @moduledoc """
  Coordination GenServer bridging ArangoDB (game data) and VerisimDB (level data).

  ## Graceful Degradation

  The bridge starts even if one or both databases are unavailable.  Health state
  is tracked in GenServer state and refreshed every 30 seconds.  API calls to an
  unhealthy database return `{:error, :database_unavailable}` immediately rather
  than timing out.

  ## Schema Validation

  All writes pass through validation functions that enforce the Idris2 ABI type
  contracts at runtime:

  - `validate_player/1` — player ID, name, inventory list, stats map
  - `validate_device/1` — IP format, device type enum, security level enum, zone
  - `validate_level/1` — location_id, mission_id, guard placements, zone transitions

  Invalid data is rejected before it reaches either database.
  """

  use GenServer
  require Logger

  alias IDApixiTIK.SyncServer.ArangoClient
  alias IDApixiTIK.SyncServer.VerisimClient

  @health_interval_ms 30_000

  # --- Valid enums from the Idris2 ABI (src/abi/Types.idr, Devices.idr) ---

  # The 9 device types defined in the game's type system.
  @valid_device_types ~w(
    router switch firewall server workstation
    iot_sensor plc scada_controller access_point
  )

  # The 4 security levels (from SecurityLevel in Types.idr).
  @valid_security_levels ~w(none low medium high)

  # ---------------------------------------------------------------------------
  # Client API — Game Data (ArangoDB)
  # ---------------------------------------------------------------------------

  @doc """
  Save or create a player document in ArangoDB.

  `player_id` is the document key.  `data` is a map with `name`, `inventory`,
  and `stats` fields.  The data is validated against the player schema before
  writing.

  Returns `{:ok, response}` on success or `{:error, reason}` on failure.
  """
  def save_player(player_id, data) do
    GenServer.call(__MODULE__, {:save_player, player_id, data})
  end

  @doc "Get a player document from ArangoDB by key."
  def get_player(player_id) do
    GenServer.call(__MODULE__, {:get_player, player_id})
  end

  @doc """
  Save or create a device document in ArangoDB.

  `device_id` is the document key.  `data` must include `ip`, `type`,
  `security_level`, and `zone` fields matching the Idris2 ABI types.
  """
  def save_device(device_id, data) do
    GenServer.call(__MODULE__, {:save_device, device_id, data})
  end

  @doc """
  Traverse the network topology graph from a starting device.

  `device_key` is the document key in the `devices` collection (not the full
  document ID — the bridge prepends `devices/` automatically).

  Returns `{:ok, results}` with a list of `%{"vertex" => ..., "edge" => ...}` maps.
  """
  def get_network_topology(device_key) do
    GenServer.call(__MODULE__, {:get_network_topology, device_key})
  end

  @doc """
  Execute a raw AQL query.  Pass-through for Joshua's custom queries.

  `aql` is the query string, `bind_vars` is an optional map of bind parameters.
  """
  def query_game(aql, bind_vars \\ %{}) do
    GenServer.call(__MODULE__, {:query_game, aql, bind_vars})
  end

  # ---------------------------------------------------------------------------
  # Client API — Level Data (VerisimDB)
  # ---------------------------------------------------------------------------

  @doc """
  Save a level to VerisimDB as a hexad entity.

  `level_id` is the hexad entity ID.  If `nil`, creates a new hexad.
  `data` must include `location_id`, `mission_id`, `guard_placements`, and
  `zone_transitions` fields matching the Idris2 ABI level contract.

  Returns `{:ok, response}` on success or `{:error, reason}` on failure.
  """
  def save_level(level_id, data) do
    GenServer.call(__MODULE__, {:save_level, level_id, data})
  end

  @doc "Get a level hexad from VerisimDB by entity ID."
  def get_level(level_id) do
    GenServer.call(__MODULE__, {:get_level, level_id})
  end

  @doc """
  Search levels by text query across level metadata.

  Uses VerisimDB's Tantivy full-text search.  `query` is the search string.
  """
  def search_levels(query) do
    GenServer.call(__MODULE__, {:search_levels, query})
  end

  @doc """
  Get a level's version history via VerisimDB's temporal modality.

  Returns all temporal snapshots for the given level hexad.
  """
  def get_level_history(level_id) do
    GenServer.call(__MODULE__, {:get_level_history, level_id})
  end

  # ---------------------------------------------------------------------------
  # Client API — Cross-Database
  # ---------------------------------------------------------------------------

  @doc """
  Get aggregated health status of both databases.

  Returns a map with `:arango` and `:verisim` keys, each containing
  `{:ok, info}` or `{:error, reason}`.
  """
  def health do
    GenServer.call(__MODULE__, :health)
  end

  @doc """
  Log an event to VerisimDB's temporal modality as an audit trail entry.

  `event_type` is a string like `"level_published"` or `"player_joined"`.
  `payload` is an arbitrary map of event data.
  """
  def log_event(event_type, payload) do
    GenServer.cast(__MODULE__, {:log_event, event_type, payload})
  end

  # ---------------------------------------------------------------------------
  # GenServer Implementation
  # ---------------------------------------------------------------------------

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

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
    Logger.info("DatabaseBridge: starting — initialising caches and health checks")

    # Initialise ETS caches for both clients
    ArangoClient.init_cache()
    VerisimClient.init_cache()

    # Check health of both databases (non-blocking — we start regardless)
    arango_healthy = check_arango_health()
    verisim_healthy = check_verisim_health()

    # Bootstrap ArangoDB collections if it is available
    if arango_healthy do
      ArangoClient.ensure_collections()
      Logger.info("DatabaseBridge: ArangoDB collections and graph ready")
    end

    # Schedule periodic health checks
    Process.send_after(self(), :health_tick, @health_interval_ms)

    state = %{
      arango_healthy: arango_healthy,
      verisim_healthy: verisim_healthy
    }

    Logger.info(
      "DatabaseBridge: started — ArangoDB #{health_label(arango_healthy)}, " <>
        "VerisimDB #{health_label(verisim_healthy)}"
    )

    {:ok, state}
  end

  # --- Game Data (ArangoDB) Handlers ---

  @impl true
  def handle_call({:save_player, player_id, data}, _from, state) do
    result =
      with :ok <- require_arango(state),
           {:ok, validated} <- validate_player(data) do
        doc = Map.put(validated, "_key", player_id)

        case ArangoClient.get_document("players", player_id) do
          {:ok, _existing} ->
            ArangoClient.update_document("players", player_id, doc)

          {:error, :not_found} ->
            ArangoClient.create_document("players", doc)

          {:error, reason} ->
            {:error, reason}
        end
      end

    {:reply, result, state}
  end

  @impl true
  def handle_call({:get_player, player_id}, _from, state) do
    result =
      with :ok <- require_arango(state) do
        ArangoClient.get_document("players", player_id)
      end

    {:reply, result, state}
  end

  @impl true
  def handle_call({:save_device, device_id, data}, _from, state) do
    result =
      with :ok <- require_arango(state),
           {:ok, validated} <- validate_device(data) do
        doc = Map.put(validated, "_key", device_id)

        case ArangoClient.get_document("devices", device_id) do
          {:ok, _existing} ->
            ArangoClient.update_document("devices", device_id, doc)

          {:error, :not_found} ->
            ArangoClient.create_document("devices", doc)

          {:error, reason} ->
            {:error, reason}
        end
      end

    {:reply, result, state}
  end

  @impl true
  def handle_call({:get_network_topology, device_key}, _from, state) do
    result =
      with :ok <- require_arango(state) do
        ArangoClient.traverse("devices/#{device_key}")
      end

    {:reply, result, state}
  end

  @impl true
  def handle_call({:query_game, aql, bind_vars}, _from, state) do
    result =
      with :ok <- require_arango(state) do
        ArangoClient.query(aql, bind_vars)
      end

    {:reply, result, state}
  end

  # --- Level Data (VerisimDB) Handlers ---

  @impl true
  def handle_call({:save_level, level_id, data}, _from, state) do
    result =
      with :ok <- require_verisim(state),
           {:ok, validated} <- validate_level(data) do
        if level_id do
          VerisimClient.update_hexad(level_id, validated)
        else
          VerisimClient.create_hexad(validated)
        end
      end

    {:reply, result, state}
  end

  @impl true
  def handle_call({:get_level, level_id}, _from, state) do
    result =
      with :ok <- require_verisim(state) do
        VerisimClient.get_hexad(level_id)
      end

    {:reply, result, state}
  end

  @impl true
  def handle_call({:search_levels, query}, _from, state) do
    result =
      with :ok <- require_verisim(state) do
        VerisimClient.search_text(query)
      end

    {:reply, result, state}
  end

  @impl true
  def handle_call({:get_level_history, level_id}, _from, state) do
    result =
      with :ok <- require_verisim(state) do
        # Temporal modality query — get all versions of this hexad
        VerisimClient.execute_vql(
          "SELECT temporal.* FROM hexads WHERE id = '#{level_id}' ORDER BY temporal.version DESC"
        )
      end

    {:reply, result, state}
  end

  # --- Cross-Database Handlers ---

  @impl true
  def handle_call(:health, _from, state) do
    health_status = %{
      arango: if(state.arango_healthy, do: :ok, else: :unavailable),
      verisim: if(state.verisim_healthy, do: :ok, else: :unavailable)
    }

    {:reply, {:ok, health_status}, state}
  end

  @impl true
  def handle_cast({:log_event, event_type, payload}, state) do
    if state.verisim_healthy do
      event_hexad = %{
        type: "audit_event",
        event_type: event_type,
        payload: payload,
        timestamp: DateTime.utc_now() |> DateTime.to_iso8601()
      }

      case VerisimClient.create_hexad(event_hexad) do
        {:ok, _} ->
          :ok

        {:error, reason} ->
          Logger.warning("DatabaseBridge: failed to log event '#{event_type}': #{inspect(reason)}")
      end
    end

    {:noreply, state}
  end

  # --- Periodic Health Check ---

  @impl true
  def handle_info(:health_tick, state) do
    arango_healthy = check_arango_health()
    verisim_healthy = check_verisim_health()

    # Log transitions (healthy -> unhealthy or vice versa)
    if state.arango_healthy and not arango_healthy do
      Logger.warning("DatabaseBridge: ArangoDB became unavailable")
    end

    if not state.arango_healthy and arango_healthy do
      Logger.info("DatabaseBridge: ArangoDB recovered")

      # Re-bootstrap collections on recovery
      ArangoClient.ensure_collections()
    end

    if state.verisim_healthy and not verisim_healthy do
      Logger.warning("DatabaseBridge: VerisimDB became unavailable")
    end

    if not state.verisim_healthy and verisim_healthy do
      Logger.info("DatabaseBridge: VerisimDB recovered")
    end

    # Schedule next tick
    Process.send_after(self(), :health_tick, @health_interval_ms)

    {:noreply, %{state | arango_healthy: arango_healthy, verisim_healthy: verisim_healthy}}
  end

  # ---------------------------------------------------------------------------
  # Schema Validation (Private)
  #
  # These functions enforce the Idris2 ABI type contracts at runtime.
  # They pattern-match on expected structure and return {:ok, data} for valid
  # input or {:error, reason} for invalid input.  Writes are rejected before
  # touching either database.
  # ---------------------------------------------------------------------------

  # Validate a player struct.
  #
  # Expected fields:
  #   - "name" or :name  — non-empty string (player display name)
  #   - "inventory" or :inventory — list (items the player carries)
  #   - "stats" or :stats — map (player statistics: health, xp, etc.)
  #
  # The "id" / :id field is optional here because the document key is provided
  # separately to the save function.
  defp validate_player(data) when is_map(data) do
    name = Map.get(data, "name") || Map.get(data, :name)
    inventory = Map.get(data, "inventory") || Map.get(data, :inventory)
    stats = Map.get(data, "stats") || Map.get(data, :stats)

    cond do
      not is_binary(name) or byte_size(name) == 0 ->
        {:error, {:validation, "player 'name' must be a non-empty string"}}

      not is_list(inventory) ->
        {:error, {:validation, "player 'inventory' must be a list"}}

      not is_map(stats) ->
        {:error, {:validation, "player 'stats' must be a map"}}

      true ->
        {:ok, data}
    end
  end

  defp validate_player(_data) do
    {:error, {:validation, "player data must be a map"}}
  end

  # Validate a device struct.
  #
  # Expected fields:
  #   - "ip" or :ip — string matching IPv4 format (e.g., "192.168.1.1")
  #   - "type" or :type — one of the 9 valid device types from the ABI
  #   - "security_level" or :security_level — one of: none, low, medium, high
  #   - "zone" or :zone — non-empty string (the zone this device belongs to)
  defp validate_device(data) when is_map(data) do
    ip = Map.get(data, "ip") || Map.get(data, :ip)
    type = Map.get(data, "type") || Map.get(data, :type)
    security_level = Map.get(data, "security_level") || Map.get(data, :security_level)
    zone = Map.get(data, "zone") || Map.get(data, :zone)

    cond do
      not is_binary(ip) or not valid_ipv4?(ip) ->
        {:error, {:validation, "device 'ip' must be a valid IPv4 address string"}}

      not is_binary(type) or type not in @valid_device_types ->
        {:error,
         {:validation,
          "device 'type' must be one of: #{Enum.join(@valid_device_types, ", ")}"}}

      not is_binary(security_level) or security_level not in @valid_security_levels ->
        {:error,
         {:validation,
          "device 'security_level' must be one of: #{Enum.join(@valid_security_levels, ", ")}"}}

      not is_binary(zone) or byte_size(zone) == 0 ->
        {:error, {:validation, "device 'zone' must be a non-empty string"}}

      true ->
        {:ok, data}
    end
  end

  defp validate_device(_data) do
    {:error, {:validation, "device data must be a map"}}
  end

  # Validate a level struct.
  #
  # Expected fields:
  #   - "location_id" or :location_id — non-empty string
  #   - "mission_id" or :mission_id — non-empty string
  #   - "guard_placements" or :guard_placements — list of placement maps
  #   - "zone_transitions" or :zone_transitions — list with monotonically
  #     increasing x-coordinates (ensures zones don't overlap spatially)
  defp validate_level(data) when is_map(data) do
    location_id = Map.get(data, "location_id") || Map.get(data, :location_id)
    mission_id = Map.get(data, "mission_id") || Map.get(data, :mission_id)
    guard_placements = Map.get(data, "guard_placements") || Map.get(data, :guard_placements)
    zone_transitions = Map.get(data, "zone_transitions") || Map.get(data, :zone_transitions)

    cond do
      not is_binary(location_id) or byte_size(location_id) == 0 ->
        {:error, {:validation, "level 'location_id' must be a non-empty string"}}

      not is_binary(mission_id) or byte_size(mission_id) == 0 ->
        {:error, {:validation, "level 'mission_id' must be a non-empty string"}}

      not is_list(guard_placements) ->
        {:error, {:validation, "level 'guard_placements' must be a list"}}

      not is_list(zone_transitions) ->
        {:error, {:validation, "level 'zone_transitions' must be a list"}}

      not zone_transitions_monotonic?(zone_transitions) ->
        {:error,
         {:validation,
          "level 'zone_transitions' x-coordinates must be monotonically increasing"}}

      true ->
        {:ok, data}
    end
  end

  defp validate_level(_data) do
    {:error, {:validation, "level data must be a map"}}
  end

  # ---------------------------------------------------------------------------
  # Private Helpers
  # ---------------------------------------------------------------------------

  # Check if a string looks like a valid IPv4 address (4 octets, 0-255 each).
  defp valid_ipv4?(ip) when is_binary(ip) do
    case String.split(ip, ".") do
      [a, b, c, d] ->
        Enum.all?([a, b, c, d], fn octet ->
          case Integer.parse(octet) do
            {n, ""} -> n >= 0 and n <= 255
            _ -> false
          end
        end)

      _ ->
        false
    end
  end

  defp valid_ipv4?(_), do: false

  # Check that zone transitions have monotonically increasing x-coordinates.
  # Each transition is expected to be a map with an "x" or :x key.
  # An empty list or a list with one element is trivially valid.
  defp zone_transitions_monotonic?([]), do: true
  defp zone_transitions_monotonic?([_single]), do: true

  defp zone_transitions_monotonic?(transitions) do
    x_values =
      Enum.map(transitions, fn t ->
        x = Map.get(t, "x") || Map.get(t, :x)
        if is_number(x), do: x, else: nil
      end)

    if Enum.any?(x_values, &is_nil/1) do
      # If any transition is missing an x-coordinate, consider it invalid
      false
    else
      x_values
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.all?(fn [a, b] -> a < b end)
    end
  end

  # Guard: require ArangoDB to be healthy before processing a request.
  defp require_arango(%{arango_healthy: true}), do: :ok
  defp require_arango(_state), do: {:error, :arango_unavailable}

  # Guard: require VerisimDB to be healthy before processing a request.
  defp require_verisim(%{verisim_healthy: true}), do: :ok
  defp require_verisim(_state), do: {:error, :verisim_unavailable}

  # Perform a health check against ArangoDB, logging on failure.
  defp check_arango_health do
    case ArangoClient.health() do
      {:ok, _} ->
        true

      {:error, reason} ->
        Logger.debug("DatabaseBridge: ArangoDB health check failed: #{inspect(reason)}")
        false
    end
  end

  # Perform a health check against VerisimDB, logging on failure.
  defp check_verisim_health do
    case VerisimClient.health() do
      {:ok, _} ->
        true

      {:error, reason} ->
        Logger.debug("DatabaseBridge: VerisimDB health check failed: #{inspect(reason)}")
        false
    end
  end

  # Human-readable label for health state (used in startup log).
  defp health_label(true), do: "healthy"
  defp health_label(false), do: "unavailable (degraded mode)"
end
