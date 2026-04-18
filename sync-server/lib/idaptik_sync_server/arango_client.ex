# SPDX-License-Identifier: PMPL-1.0-or-later
#
# ArangoClient — HTTP client for ArangoDB REST API.
#
# Provides typed access to ArangoDB's document, collection, and graph APIs
# with transparent ETS caching (read-through, TTL-based expiry, write-invalidate).
#
# Follows the same Req + ETS cache + TTL pattern established by
# VeriSim.RustClient in the VerisimDB elixir-orchestration layer.
#
# ArangoDB is used for Joshua's live game data:
#   - players     (document)  — player state, inventory, stats, progression
#   - sessions    (document)  — game session metadata
#   - devices     (document)  — network devices (IP, type, security level, zone)
#   - zones       (document)  — network zones (LAN, DMZ, SCADA, etc.)
#   - network_edges (edge)    — device-to-device connections
#   - network_topology (graph) — named graph over devices + network_edges
#
# All reads are cached in ETS with a 30-second TTL. Writes invalidate the
# relevant cache key immediately. Cache misses fall through to HTTP.
#
# Configuration (via Application env):
#
#   config :idaptik_sync_server, IDApixiTIK.SyncServer.ArangoClient,
#     url: "http://localhost:8529",
#     database: "idaptik",
#     user: "root",
#     password: ""

defmodule IDApixiTIK.SyncServer.ArangoClient do
  @moduledoc """
  HTTP client for ArangoDB REST API with ETS caching.

  Handles document CRUD, collection management, AQL queries, and graph
  traversals against ArangoDB's `/_api/` endpoints.  Every request includes
  Basic auth derived from application config.

  ## Caching

  GET requests for individual documents are cached in a dedicated ETS table
  (`:idaptik_arango_cache`) with a 30-second TTL.  Writes (`create`, `update`,
  `delete`) invalidate the affected key so the next read fetches fresh data.

  ## Graph Traversal

  `traverse/3` wraps AQL's `FOR v, e IN 1..depth OUTBOUND/INBOUND startVertex
  GRAPH 'network_topology'` pattern, which is the core query for IDApTIK's
  network-hacking gameplay — tracing paths between devices.
  """

  require Logger

  @cache_table :idaptik_arango_cache
  @cache_ttl_ms 30_000

  # --- Document collections (created on startup by ensure_collections/0) ---
  @document_collections ~w(players sessions devices zones)
  # --- Edge collections ---
  @edge_collections ~w(network_edges)
  # --- Named graph ---
  @graph_name "network_topology"

  # ---------------------------------------------------------------------------
  # ETS Cache — transparent read-through with TTL-based expiry
  # ---------------------------------------------------------------------------

  @doc """
  Initialise the ETS cache table for ArangoDB document lookups.

  Called once from `DatabaseBridge.init/1`.  Safe to call multiple times —
  checks whether the table already exists before creating it.
  """
  def init_cache do
    if :ets.info(@cache_table) == :undefined do
      :ets.new(@cache_table, [:set, :public, :named_table, read_concurrency: true])
    end

    :ok
  end

  @doc "Delete all cached entries (e.g., after a bulk import or schema change)."
  def clear_cache do
    if :ets.info(@cache_table) != :undefined do
      :ets.delete_all_objects(@cache_table)
    end

    :ok
  end

  @doc "Invalidate a single cache key after a write operation."
  def invalidate_cache(key) do
    if :ets.info(@cache_table) != :undefined do
      :ets.delete(@cache_table, key)
    end

    :ok
  end

  # Lookup a key in the cache.  Returns `{:hit, value}` if the entry exists
  # and has not expired, or `:miss` otherwise.  Expired entries are deleted
  # eagerly on access.
  defp cache_get(key) do
    if :ets.info(@cache_table) != :undefined do
      case :ets.lookup(@cache_table, key) do
        [{^key, value, expiry}] ->
          if System.monotonic_time(:millisecond) < expiry do
            {:hit, value}
          else
            :ets.delete(@cache_table, key)
            :miss
          end

        _ ->
          :miss
      end
    else
      :miss
    end
  end

  # Store a value in the cache with a TTL.  Returns the value unchanged
  # (pass-through) so it can be used inline: `cache_put(key, body)`.
  defp cache_put(key, value, ttl_ms \\ @cache_ttl_ms) do
    if :ets.info(@cache_table) != :undefined do
      expiry = System.monotonic_time(:millisecond) + ttl_ms
      :ets.insert(@cache_table, {key, value, expiry})
    end

    value
  end

  # ---------------------------------------------------------------------------
  # Configuration
  # ---------------------------------------------------------------------------

  defp config do
    Application.get_env(:idaptik_sync_server, __MODULE__, [])
  end

  defp base_url do
    url = Keyword.get(config(), :url, "http://localhost:8529")
    database = Keyword.get(config(), :database, "idaptik")
    "#{url}/_db/#{database}"
  end

  # System-level URL (e.g., /_api/version) that does not include the database path.
  defp system_url do
    Keyword.get(config(), :url, "http://localhost:8529")
  end

  defp auth_header do
    user = Keyword.get(config(), :user, "root")
    password = Keyword.get(config(), :password, "")
    encoded = Base.encode64("#{user}:#{password}")
    {"authorization", "Basic #{encoded}"}
  end

  defp timeout do
    Keyword.get(config(), :timeout, 30_000)
  end

  # ---------------------------------------------------------------------------
  # Health Check
  # ---------------------------------------------------------------------------

  @doc """
  Check ArangoDB availability via `GET /_api/version`.

  Returns `{:ok, body}` on success (HTTP 200) or `{:error, reason}` on failure.
  Used by `DatabaseBridge` for periodic health monitoring.
  """
  def health do
    url = system_url() <> "/_api/version"

    case do_get(url) do
      {:ok, %{status: 200, body: body}} ->
        {:ok, body}

      {:ok, %{status: status}} ->
        {:error, {:unhealthy, status}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  # ---------------------------------------------------------------------------
  # Collection & Graph Bootstrap
  # ---------------------------------------------------------------------------

  @doc """
  Ensure all required collections and the named graph exist in ArangoDB.

  Idempotent — checks existence before creating.  Called from
  `DatabaseBridge.init/1` on startup.

  Creates:
  - Document collections: `players`, `sessions`, `devices`, `zones`
  - Edge collection: `network_edges`
  - Named graph: `network_topology` (vertices: `devices`, edges: `network_edges`)
  """
  def ensure_collections do
    # Document collections
    for name <- @document_collections do
      ensure_collection(name, :document)
    end

    # Edge collections
    for name <- @edge_collections do
      ensure_collection(name, :edge)
    end

    # Named graph
    ensure_graph()

    :ok
  end

  # Create a single collection if it does not already exist.
  # `type` is `:document` (2) or `:edge` (3) per ArangoDB API.
  defp ensure_collection(name, type) do
    type_int = if type == :edge, do: 3, else: 2
    url = base_url() <> "/_api/collection"

    case do_post(url, %{name: name, type: type_int}) do
      {:ok, %{status: status}} when status in [200, 409] ->
        # 200 = created, 409 = already exists — both are fine
        Logger.debug("ArangoDB collection '#{name}' ready (status #{status})")
        :ok

      {:ok, %{status: status, body: body}} ->
        Logger.warning("ArangoDB: failed to create collection '#{name}': #{status} #{inspect(body)}")
        {:error, {status, body}}

      {:error, reason} ->
        Logger.warning("ArangoDB: failed to create collection '#{name}': #{inspect(reason)}")
        {:error, reason}
    end
  end

  # Create the named graph if it does not already exist.  The graph definition
  # links the `devices` vertex collection to the `network_edges` edge collection.
  defp ensure_graph do
    url = base_url() <> "/_api/gharial"

    graph_def = %{
      name: @graph_name,
      edgeDefinitions: [
        %{
          collection: "network_edges",
          from: ["devices"],
          to: ["devices"]
        }
      ],
      orphanCollections: ["zones"]
    }

    case do_post(url, graph_def) do
      {:ok, %{status: status}} when status in [201, 202, 409] ->
        Logger.debug("ArangoDB graph '#{@graph_name}' ready (status #{status})")
        :ok

      {:ok, %{status: status, body: body}} ->
        Logger.warning("ArangoDB: failed to create graph '#{@graph_name}': #{status} #{inspect(body)}")
        {:error, {status, body}}

      {:error, reason} ->
        Logger.warning("ArangoDB: failed to create graph '#{@graph_name}': #{inspect(reason)}")
        {:error, reason}
    end
  end

  # ---------------------------------------------------------------------------
  # Document CRUD
  # ---------------------------------------------------------------------------

  @doc """
  Create a document in the given collection.

  Returns `{:ok, body}` with the ArangoDB response (including `_key`, `_id`,
  `_rev`) on success, or `{:error, reason}` on failure.
  """
  def create_document(collection, document) do
    url = base_url() <> "/_api/document/#{collection}"

    case do_post(url, document) do
      {:ok, %{status: status, body: body}} when status in [200, 201, 202] ->
        {:ok, body}

      {:ok, %{status: status, body: body}} ->
        {:error, {status, body}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Get a document by key from the given collection.  Cached with 30s TTL.

  Returns `{:ok, body}` on cache hit or successful HTTP fetch, `{:error, :not_found}`
  if the document does not exist, or `{:error, reason}` on failure.
  """
  def get_document(collection, key) do
    cache_key = {:arango, collection, key}

    case cache_get(cache_key) do
      {:hit, cached} ->
        {:ok, cached}

      :miss ->
        url = base_url() <> "/_api/document/#{collection}/#{key}"

        case do_get(url) do
          {:ok, %{status: 200, body: body}} ->
            cache_put(cache_key, body)
            {:ok, body}

          {:ok, %{status: 404}} ->
            {:error, :not_found}

          {:ok, %{status: status, body: body}} ->
            {:error, {status, body}}

          {:error, reason} ->
            {:error, reason}
        end
    end
  end

  @doc """
  Update (replace) a document in the given collection.  Invalidates cache.

  Uses `PUT` (full replace).  Returns `{:ok, body}` on success.
  """
  def update_document(collection, key, document) do
    url = base_url() <> "/_api/document/#{collection}/#{key}"
    invalidate_cache({:arango, collection, key})

    case do_put(url, document) do
      {:ok, %{status: status, body: body}} when status in [200, 201, 202] ->
        {:ok, body}

      {:ok, %{status: 404}} ->
        {:error, :not_found}

      {:ok, %{status: status, body: body}} ->
        {:error, {status, body}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Delete a document from the given collection.  Invalidates cache.

  Returns `:ok` on success, `{:error, :not_found}` if the document does not
  exist, or `{:error, reason}` on failure.
  """
  def delete_document(collection, key) do
    url = base_url() <> "/_api/document/#{collection}/#{key}"
    invalidate_cache({:arango, collection, key})

    case do_delete(url) do
      {:ok, %{status: status}} when status in [200, 202] ->
        :ok

      {:ok, %{status: 404}} ->
        {:error, :not_found}

      {:ok, %{status: status, body: body}} ->
        {:error, {status, body}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  # ---------------------------------------------------------------------------
  # AQL Queries
  # ---------------------------------------------------------------------------

  @doc """
  Execute an AQL query via `POST /_api/cursor`.

  `aql` is the query string.  `bind_vars` is an optional map of bind parameters.

  Returns `{:ok, results}` where `results` is the list from the `result` field
  of the cursor response, or `{:error, reason}` on failure.

  ## Example

      ArangoClient.query("FOR p IN players FILTER p.name == @name RETURN p",
                          %{name: "Joshua"})
  """
  def query(aql, bind_vars \\ %{}) do
    url = base_url() <> "/_api/cursor"

    payload = %{query: aql, bindVars: bind_vars}

    case do_post(url, payload) do
      {:ok, %{status: status, body: %{"result" => results}}} when status in [200, 201] ->
        {:ok, results}

      {:ok, %{status: status, body: body}} ->
        {:error, {status, body}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Traverse the `network_topology` graph from a starting vertex.

  Wraps AQL's graph traversal:

      FOR v, e IN 1..depth OUTBOUND/INBOUND startVertex GRAPH 'network_topology'
        RETURN {vertex: v, edge: e}

  ## Parameters

  - `start_vertex` — full document ID, e.g., `"devices/router_01"`
  - `depth` — maximum traversal depth (default: 3)
  - `direction` — `:outbound`, `:inbound`, or `:any` (default: `:outbound`)

  Returns `{:ok, results}` with a list of `%{"vertex" => ..., "edge" => ...}` maps.
  """
  def traverse(start_vertex, depth \\ 3, direction \\ :outbound) do
    dir_str =
      case direction do
        :inbound -> "INBOUND"
        :any -> "ANY"
        _ -> "OUTBOUND"
      end

    aql = """
    FOR v, e IN 1..@depth #{dir_str} @start GRAPH '#{@graph_name}'
      RETURN {vertex: v, edge: e}
    """

    query(aql, %{depth: depth, start: start_vertex})
  end

  # ---------------------------------------------------------------------------
  # HTTP Helpers (private) — Req-based, with Basic auth on every request
  # ---------------------------------------------------------------------------

  defp do_get(url, params \\ []) do
    {header_key, header_val} = auth_header()

    Req.get(url,
      params: params,
      headers: [{header_key, header_val}],
      receive_timeout: timeout(),
      retry: false,
      decode_body: true
    )
  rescue
    e -> {:error, {:request_failed, e}}
  end

  defp do_post(url, body) do
    {header_key, header_val} = auth_header()

    Req.post(url,
      json: body,
      headers: [{header_key, header_val}],
      receive_timeout: timeout(),
      retry: false,
      decode_body: true
    )
  rescue
    e -> {:error, {:request_failed, e}}
  end

  defp do_put(url, body) do
    {header_key, header_val} = auth_header()

    Req.put(url,
      json: body,
      headers: [{header_key, header_val}],
      receive_timeout: timeout(),
      retry: false,
      decode_body: true
    )
  rescue
    e -> {:error, {:request_failed, e}}
  end

  defp do_delete(url) do
    {header_key, header_val} = auth_header()

    Req.delete(url,
      headers: [{header_key, header_val}],
      receive_timeout: timeout(),
      retry: false,
      decode_body: true
    )
  rescue
    e -> {:error, {:request_failed, e}}
  end
end
