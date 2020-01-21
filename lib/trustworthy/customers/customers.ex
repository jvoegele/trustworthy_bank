defmodule Trustworthy.Customers do
  @moduledoc """
  The Customers context.
  """

  import Ecto.Query, warn: false

  alias Trustworthy.Repo
  alias Trustworthy.CommandRouter
  alias Trustworthy.Customers.{Commands, Projections}
  alias FE.Maybe
  alias FE.Result

  @type uuid :: String.t()
  @type username :: String.t()

  @doc """
  Register a new user.
  """
  @spec register_user(map()) :: Result.t(%Projections.User{})
  def register_user(attrs \\ %{}) do
    uuid = UUID.uuid4()

    attrs
    |> Map.put(:user_uuid, uuid)
    |> Commands.RegisterUser.new()
    |> CommandRouter.dispatch(consistency: :strong)
    |> case do
      :ok -> Projections.User |> Repo.fetch(uuid) |> Maybe.to_result(:not_found)
      error -> error
    end
  end

  @doc """
  Get an existing user by their username, or return `:nothing` if not registered.
  """
  @spec user_by_username(username()) :: Maybe.t(%Projections.User{})
  def user_by_username(username) when is_binary(username) do
    username
    |> String.downcase()
    |> Projections.User.Query.by_username()
    |> Repo.one()
    |> Maybe.new()
  end

  @doc """
  Get a single user by their UUID
  """
  def user_by_uuid(uuid) when is_binary(uuid) do
    Repo.get(Projections.User, uuid)
  end
end
