defmodule OpenStax.Swift.AuthAgent do
  @moduledoc """
    This module is responsible for storing configuration of Swift backends.
  """

  @doc """
  Starts a new agent for storing configuration.
  """
  def start_link(opts \\ []) do
    Agent.start_link(fn -> %{} end, opts)
  end


  @doc """
  Registers new backend.
  """
  def register(backend_id, auth_token \\ nil, endpoint_url \\ nil, signing_key \\ nil) do
    Agent.update(OpenStax.Swift.AuthAgent, fn(state) ->
      Map.put(state, backend_id, %{auth_token: auth_token, endpoint_url: endpoint_url, signing_key: signing_key})
    end)
  end


  @doc """
  Returns current access token for a backend.
  """
  def get_config(backend_id) do
    Agent.get(OpenStax.Swift.AuthAgent, fn(state) ->
      Map.get(state, backend_id)
    end)
  end


  @doc """
  Sets current configuration for a backend.
  """
  def set_config(backend_id, auth_token, endpoint_url, signing_key \\ nil) do
    Agent.update(OpenStax.Swift.AuthAgent, fn(state) ->
      Map.put(state, backend_id, %{auth_token: auth_token, endpoint_url: endpoint_url, signing_key: signing_key})
    end)
  end
end
