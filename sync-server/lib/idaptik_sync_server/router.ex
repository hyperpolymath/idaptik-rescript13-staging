# SPDX-License-Identifier: PMPL-1.0-or-later
# Copyright (c) 2026 Joshua B. Jewell and Jonathan D.A. Jewell
defmodule IDApixiTIK.SyncServer.Router do
  use Plug.Router

  plug Plug.Logger
  plug :cors_headers
  plug :match
  plug :dispatch

  # CORS support for browser clients
  defp cors_headers(conn, _opts) do
    conn
    |> put_resp_header("access-control-allow-origin", "*")
    |> put_resp_header("access-control-allow-methods", "GET, POST, OPTIONS")
    |> put_resp_header("access-control-allow-headers", "content-type")
  end

  # Health check — used by container HEALTHCHECK and load balancers
  get "/health" do
    send_resp(conn, 200, Jason.encode!(%{status: "ok"}))
  end

  # Info root
  get "/" do
    send_resp(conn, 200, Jason.encode!(%{
      status: "active",
      server: "IDApTIK Sync Server",
      version: "0.2.0",
      channels: ["level:*", "game:*"]
    }))
  end

  # CORS preflight
  options _ do
    send_resp(conn, 204, "")
  end

  # Level editor sync (REST fallback for non-WebSocket clients)
  post "/sync/:level_id" do
    IDApixiTIK.SyncServer.GameStore.update_level(level_id, conn.body_params)
    send_resp(conn, 200, Jason.encode!(%{ok: true}))
  end

  get "/sync/:level_id" do
    case IDApixiTIK.SyncServer.GameStore.get_level(level_id) do
      nil -> send_resp(conn, 404, Jason.encode!(%{error: "not_found"}))
      data ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(data))
    end
  end

  # Game session info
  get "/sessions" do
    sessions = IDApixiTIK.SyncServer.GameSessionRegistry.list_sessions()
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(sessions))
  end

  get "/sessions/:session_id" do
    case IDApixiTIK.SyncServer.GameSessionRegistry.get_session(session_id) do
      nil -> send_resp(conn, 404, Jason.encode!(%{error: "not_found"}))
      session ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(session))
    end
  end

  # ---------------------------------------------------------------------------
  # Database Federation API — /db/*
  #
  # Routes for the ArangoDB + VerisimDB bridge.  Separated from existing
  # /sync/ and /sessions/ namespaces.  All routes delegate to DatabaseBridge
  # which handles validation, caching, and routing to the correct database.
  # ---------------------------------------------------------------------------

  alias IDApixiTIK.SyncServer.DatabaseBridge

  # Aggregated health of both databases
  get "/db/health" do
    case DatabaseBridge.health() do
      {:ok, status} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(status))

      {:error, reason} ->
        send_resp(conn, 503, Jason.encode!(%{error: inspect(reason)}))
    end
  end

  # Get player from ArangoDB
  get "/db/players/:id" do
    case DatabaseBridge.get_player(id) do
      {:ok, player} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(player))

      {:error, :not_found} ->
        send_resp(conn, 404, Jason.encode!(%{error: "not_found"}))

      {:error, :arango_unavailable} ->
        send_resp(conn, 503, Jason.encode!(%{error: "arango_unavailable"}))

      {:error, reason} ->
        send_resp(conn, 500, Jason.encode!(%{error: inspect(reason)}))
    end
  end

  # Save player to ArangoDB
  post "/db/players" do
    id = Map.get(conn.body_params, "id") || Map.get(conn.body_params, "player_id")

    if is_nil(id) do
      send_resp(conn, 400, Jason.encode!(%{error: "missing 'id' or 'player_id' field"}))
    else
      case DatabaseBridge.save_player(id, conn.body_params) do
        {:ok, result} ->
          conn
          |> put_resp_content_type("application/json")
          |> send_resp(200, Jason.encode!(result))

        {:error, {:validation, msg}} ->
          send_resp(conn, 422, Jason.encode!(%{error: msg}))

        {:error, :arango_unavailable} ->
          send_resp(conn, 503, Jason.encode!(%{error: "arango_unavailable"}))

        {:error, reason} ->
          send_resp(conn, 500, Jason.encode!(%{error: inspect(reason)}))
      end
    end
  end

  # Graph traversal from a device in the network topology
  get "/db/topology/:device" do
    case DatabaseBridge.get_network_topology(device) do
      {:ok, results} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(results))

      {:error, :arango_unavailable} ->
        send_resp(conn, 503, Jason.encode!(%{error: "arango_unavailable"}))

      {:error, reason} ->
        send_resp(conn, 500, Jason.encode!(%{error: inspect(reason)}))
    end
  end

  # Execute a raw AQL query against ArangoDB
  post "/db/query" do
    aql = Map.get(conn.body_params, "query", "")
    bind_vars = Map.get(conn.body_params, "bindVars", %{})

    case DatabaseBridge.query_game(aql, bind_vars) do
      {:ok, results} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(results))

      {:error, :arango_unavailable} ->
        send_resp(conn, 503, Jason.encode!(%{error: "arango_unavailable"}))

      {:error, reason} ->
        send_resp(conn, 500, Jason.encode!(%{error: inspect(reason)}))
    end
  end

  # Get level from VerisimDB
  get "/db/levels/:id" do
    case DatabaseBridge.get_level(id) do
      {:ok, level} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(level))

      {:error, :not_found} ->
        send_resp(conn, 404, Jason.encode!(%{error: "not_found"}))

      {:error, :verisim_unavailable} ->
        send_resp(conn, 503, Jason.encode!(%{error: "verisim_unavailable"}))

      {:error, reason} ->
        send_resp(conn, 500, Jason.encode!(%{error: inspect(reason)}))
    end
  end

  # Save level to VerisimDB
  post "/db/levels" do
    level_id = Map.get(conn.body_params, "id")

    case DatabaseBridge.save_level(level_id, conn.body_params) do
      {:ok, result} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(result))

      {:error, {:validation, msg}} ->
        send_resp(conn, 422, Jason.encode!(%{error: msg}))

      {:error, :verisim_unavailable} ->
        send_resp(conn, 503, Jason.encode!(%{error: "verisim_unavailable"}))

      {:error, reason} ->
        send_resp(conn, 500, Jason.encode!(%{error: inspect(reason)}))
    end
  end

  # Search levels by text query
  get "/db/levels/search" do
    query = Map.get(conn.query_params, "q", "")

    case DatabaseBridge.search_levels(query) do
      {:ok, results} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(results))

      {:error, :verisim_unavailable} ->
        send_resp(conn, 503, Jason.encode!(%{error: "verisim_unavailable"}))

      {:error, reason} ->
        send_resp(conn, 500, Jason.encode!(%{error: inspect(reason)}))
    end
  end

  # ---------------------------------------------------------------------------
  # Portfolio & Campaign API — /db/portfolios/*, /db/campaigns/*
  #
  # Portfolios are collections of generated buildings stored as VerisimDB hexads.
  # Campaign graphs define mission progression edges stored in ArangoDB.
  # ---------------------------------------------------------------------------

  # Save portfolio to VerisimDB
  post "/db/portfolios" do
    portfolio_id = Map.get(conn.body_params, "id")

    case DatabaseBridge.save_level(portfolio_id, Map.put(conn.body_params, "type", "portfolio")) do
      {:ok, result} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(result))

      {:error, {:validation, msg}} ->
        send_resp(conn, 422, Jason.encode!(%{error: msg}))

      {:error, :verisim_unavailable} ->
        send_resp(conn, 503, Jason.encode!(%{error: "verisim_unavailable"}))

      {:error, reason} ->
        send_resp(conn, 500, Jason.encode!(%{error: inspect(reason)}))
    end
  end

  # Get portfolio from VerisimDB
  get "/db/portfolios/:id" do
    case DatabaseBridge.get_level(id) do
      {:ok, portfolio} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(portfolio))

      {:error, :not_found} ->
        send_resp(conn, 404, Jason.encode!(%{error: "not_found"}))

      {:error, :verisim_unavailable} ->
        send_resp(conn, 503, Jason.encode!(%{error: "verisim_unavailable"}))

      {:error, reason} ->
        send_resp(conn, 500, Jason.encode!(%{error: inspect(reason)}))
    end
  end

  # Search portfolios by name
  get "/db/portfolios/search" do
    query = Map.get(conn.query_params, "q", "")

    case DatabaseBridge.search_levels(query) do
      {:ok, results} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(results))

      {:error, :verisim_unavailable} ->
        send_resp(conn, 503, Jason.encode!(%{error: "verisim_unavailable"}))

      {:error, reason} ->
        send_resp(conn, 500, Jason.encode!(%{error: inspect(reason)}))
    end
  end

  # Save campaign graph to ArangoDB
  post "/db/campaigns" do
    portfolio_id = Map.get(conn.body_params, "portfolioId", "")
    edges = Map.get(conn.body_params, "edges", [])

    aql = """
    FOR edge IN @edges
      UPSERT { _from: CONCAT("buildings/", edge.fromBuildingId), _to: CONCAT("buildings/", edge.toBuildingId) }
      INSERT { _from: CONCAT("buildings/", edge.fromBuildingId), _to: CONCAT("buildings/", edge.toBuildingId), edgeType: edge.edgeType, label: edge.label, unlockCondition: edge.unlockCondition, portfolioId: @portfolioId }
      UPDATE { edgeType: edge.edgeType, label: edge.label, unlockCondition: edge.unlockCondition }
      IN campaign_edges
      RETURN NEW
    """

    case DatabaseBridge.query_game(aql, %{"edges" => edges, "portfolioId" => portfolio_id}) do
      {:ok, results} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{ok: true, count: length(results)}))

      {:error, :arango_unavailable} ->
        send_resp(conn, 503, Jason.encode!(%{error: "arango_unavailable"}))

      {:error, reason} ->
        send_resp(conn, 500, Jason.encode!(%{error: inspect(reason)}))
    end
  end

  # Get campaign graph for a portfolio from ArangoDB
  get "/db/campaigns/:id" do
    aql = """
    FOR edge IN campaign_edges
      FILTER edge.portfolioId == @portfolioId
      RETURN {
        fromBuildingId: SPLIT(edge._from, "/")[1],
        toBuildingId: SPLIT(edge._to, "/")[1],
        edgeType: edge.edgeType,
        label: edge.label,
        unlockCondition: edge.unlockCondition
      }
    """

    case DatabaseBridge.query_game(aql, %{"portfolioId" => id}) do
      {:ok, results} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{portfolioId: id, edges: results}))

      {:error, :arango_unavailable} ->
        send_resp(conn, 503, Jason.encode!(%{error: "arango_unavailable"}))

      {:error, reason} ->
        send_resp(conn, 500, Jason.encode!(%{error: inspect(reason)}))
    end
  end

  # Add a single edge to a campaign
  post "/db/campaigns/:id/edges" do
    from_id = Map.get(conn.body_params, "fromBuildingId", "")
    to_id = Map.get(conn.body_params, "toBuildingId", "")
    edge_type = Map.get(conn.body_params, "edgeType", "Unlocks")
    label = Map.get(conn.body_params, "label", "")
    condition = Map.get(conn.body_params, "unlockCondition")

    aql = """
    INSERT {
      _from: CONCAT("buildings/", @fromId),
      _to: CONCAT("buildings/", @toId),
      edgeType: @edgeType,
      label: @label,
      unlockCondition: @condition,
      portfolioId: @portfolioId
    } INTO campaign_edges
    RETURN NEW
    """

    bind_vars = %{
      "fromId" => from_id,
      "toId" => to_id,
      "edgeType" => edge_type,
      "label" => label,
      "condition" => condition,
      "portfolioId" => id
    }

    case DatabaseBridge.query_game(aql, bind_vars) do
      {:ok, results} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{ok: true, edge: List.first(results)}))

      {:error, :arango_unavailable} ->
        send_resp(conn, 503, Jason.encode!(%{error: "arango_unavailable"}))

      {:error, reason} ->
        send_resp(conn, 500, Jason.encode!(%{error: inspect(reason)}))
    end
  end

  match _ do
    send_resp(conn, 404, Jason.encode!(%{error: "not_found"}))
  end
end
