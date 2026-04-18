# SPDX-License-Identifier: PMPL-1.0-or-later
#
# VerisimClient — HTTP client for VerisimDB REST API.
#
# Adapted from VeriSim.RustClient (verisimdb/elixir-orchestration) but scoped
# to level architect needs.  Uses the same Req + ETS cache + TTL pattern.
#
# VerisimDB stores level architect data:
#   - Level definitions as hexad entities (6 synchronised modalities)
#   - Version history via temporal modality (native, not audit tables)
#   - Level similarity search via vector embeddings
#   - Validation logs and simulation results as semantic proof blobs
#   - Cross-level analytics via drift detection
#
# Each level is stored as a hexad — one entity with graph, vector, tensor,
# semantic, document, and temporal representations.  The temporal modality
# gives us free version history; the vector modality enables "find levels
# similar to this one"; the semantic modality stores placement proofs.
#
# Configuration (via Application env):
#
#   config :idaptik_sync_server, IDApixiTIK.SyncServer.VerisimClient,
#     url: "http://localhost:8080/api/v1",
#     timeout: 30_000

defmodule IDApixiTIK.SyncServer.VerisimClient do
  @moduledoc """
  HTTP client for VerisimDB REST API with ETS caching.

  Provides hexad CRUD, text search, related-entity queries, and raw VQL
  execution against a running VerisimDB instance.  Reads are cached in ETS
  with a 30-second TTL; writes invalidate the affected cache key.

  ## VerisimDB Hexad Modalities for Level Data

  | Modality   | Level Architect Usage                                    |
  |------------|----------------------------------------------------------|
  | Graph      | Zone adjacency, guard patrol routes, device connectivity |
  | Vector     | Level embedding for similarity search                    |
  | Tensor     | Heatmaps of player death locations, difficulty curves    |
  | Semantic   | Placement validity proofs, zone ordering invariants      |
  | Document   | Full-text searchable level descriptions, designer notes  |
  | Temporal   | Edit history, version snapshots, rollback targets        |
  """

  require Logger

  @cache_table :idaptik_verisim_cache
  @cache_ttl_ms 30_000

  # ---------------------------------------------------------------------------
  # ETS Cache — same pattern as ArangoClient and VeriSim.RustClient
  # ---------------------------------------------------------------------------

  @doc """
  Initialise the ETS cache table for VerisimDB hexad lookups.

  Called once from `DatabaseBridge.init/1`.  Safe to call multiple times.
  """
  def init_cache do
    if :ets.info(@cache_table) == :undefined do
      :ets.new(@cache_table, [:set, :public, :named_table, read_concurrency: true])
    end

    :ok
  end

  @doc "Delete all cached entries."
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
    Keyword.get(config(), :url, "http://localhost:8080/api/v1")
  end

  defp timeout do
    Keyword.get(config(), :timeout, 30_000)
  end

  # ---------------------------------------------------------------------------
  # Health Check
  # ---------------------------------------------------------------------------

  @doc """
  Check VerisimDB availability via `GET /api/v1/health`.

  Returns `{:ok, body}` on success or `{:error, reason}` on failure.
  Used by `DatabaseBridge` for periodic health monitoring.
  """
  def health do
    case get("/health") do
      {:ok, %{status: 200, body: body}} ->
        {:ok, body}

      {:ok, %{status: status}} ->
        {:error, {:unhealthy, status}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  # ---------------------------------------------------------------------------
  # Hexad CRUD — Level data as hexad entities
  # ---------------------------------------------------------------------------

  @doc """
  Create a new hexad entity (i.e., a new level) in VerisimDB.

  `input` is a map containing the hexad data — typically the level definition
  with fields for each modality that VerisimDB should populate.

  Returns `{:ok, body}` with the created hexad (including ID) on success.
  """
  def create_hexad(input) do
    case post("/hexads", input) do
      {:ok, %{status: status, body: body}} when status in [200, 201] ->
        {:ok, body}

      {:ok, %{status: status, body: body}} ->
        {:error, {status, body}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Get a hexad by entity ID.  Cached with 30s TTL.

  Returns `{:ok, body}` on cache hit or successful fetch, `{:error, :not_found}`
  if the hexad does not exist, or `{:error, reason}` on failure.
  """
  def get_hexad(entity_id) do
    cache_key = {:verisim_hexad, entity_id}

    case cache_get(cache_key) do
      {:hit, cached} ->
        {:ok, cached}

      :miss ->
        case get("/hexads/#{entity_id}") do
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
  Update an existing hexad (level).  Invalidates cache.

  Uses `PUT` (full replace).  Returns `{:ok, body}` on success.
  """
  def update_hexad(entity_id, changes) do
    invalidate_cache({:verisim_hexad, entity_id})

    case put("/hexads/#{entity_id}", changes) do
      {:ok, %{status: 200, body: body}} ->
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
  Delete a hexad (level).  Invalidates cache.

  Returns `:ok` on success or `{:error, reason}` on failure.
  """
  def delete_hexad(entity_id) do
    invalidate_cache({:verisim_hexad, entity_id})

    case delete("/hexads/#{entity_id}") do
      {:ok, %{status: status}} when status in [200, 204] ->
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
  # Search — Level discovery and similarity
  # ---------------------------------------------------------------------------

  @doc """
  Full-text search across level metadata via Tantivy.

  `query` is the search string.  `limit` caps the number of results (default 10).

  Returns `{:ok, results}` with a list of matching hexad summaries.

  ## Example

      VerisimClient.search_text("SCADA zone with 3 guards", 5)
  """
  def search_text(query, limit \\ 10) do
    case get("/search/text", q: query, limit: limit) do
      {:ok, %{status: 200, body: body}} ->
        {:ok, body}

      {:ok, %{status: status, body: body}} ->
        {:error, {status, body}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Get related hexads (levels) via the graph modality.

  Returns levels that share structural relationships with the given level —
  e.g., shared zone types, similar device layouts, or explicit dependency edges.
  """
  def get_related(entity_id) do
    case get("/search/related/#{entity_id}") do
      {:ok, %{status: 200, body: body}} ->
        {:ok, body}

      {:ok, %{status: 404}} ->
        {:error, :not_found}

      {:ok, %{status: status, body: body}} ->
        {:error, {status, body}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  # ---------------------------------------------------------------------------
  # VQL — Raw query execution
  # ---------------------------------------------------------------------------

  @doc """
  Execute a raw VQL (VerisimDB Query Language) query.

  `vql_string` is the query text.  Returns `{:ok, body}` with the query results.

  ## Example

      VerisimClient.execute_vql("SELECT * FROM hexads WHERE modality.temporal.version > 3")
  """
  def execute_vql(vql_string) do
    case post("/vql/execute", %{query: vql_string}) do
      {:ok, %{status: 200, body: body}} ->
        {:ok, body}

      {:ok, %{status: status, body: body}} ->
        {:error, {status, body}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  # ---------------------------------------------------------------------------
  # HTTP Helpers (private) — Req-based, same pattern as VeriSim.RustClient
  # ---------------------------------------------------------------------------

  defp get(path, params \\ []) do
    url = base_url() <> path

    Req.get(url,
      params: params,
      receive_timeout: timeout(),
      retry: false,
      decode_body: true
    )
  rescue
    e -> {:error, {:request_failed, e}}
  end

  defp post(path, body) do
    url = base_url() <> path

    Req.post(url,
      json: body,
      receive_timeout: timeout(),
      retry: false,
      decode_body: true
    )
  rescue
    e -> {:error, {:request_failed, e}}
  end

  defp put(path, body) do
    url = base_url() <> path

    Req.put(url,
      json: body,
      receive_timeout: timeout(),
      retry: false,
      decode_body: true
    )
  rescue
    e -> {:error, {:request_failed, e}}
  end

  defp delete(path) do
    url = base_url() <> path

    Req.delete(url,
      receive_timeout: timeout(),
      retry: false,
      decode_body: true
    )
  rescue
    e -> {:error, {:request_failed, e}}
  end
end
