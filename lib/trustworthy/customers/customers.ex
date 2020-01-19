defmodule Trustworthy.Customers do
  @moduledoc """
  The Customers context.
  """

  import Ecto.Query, warn: false

  alias Trustworthy.Repo
  alias Trustworthy.CommandRouter
  alias Trustworthy.Customers.{Commands, Projections}

  @type uuid :: String.t()
  @type username :: String.t()

  @doc """
  Register a new user.
  """
  def register_user(attrs \\ %{}) do
    uuid = UUID.uuid4()

    attrs
    |> Map.put(:user_uuid, uuid)
    |> Commands.RegisterUser.new()
    |> CommandRouter.dispatch(consistency: :strong)
    |> case do
      :ok -> Repo.fetch(Projections.User, uuid)
      error -> error
    end
  end

  @doc """
  Get an existing user by their username, or return `nil` if not registered
  """
  def user_by_username(username) when is_binary(username) do
    username
    |> String.downcase()
    |> Projections.User.Query.by_username()
    |> Repo.one()
  end
end
