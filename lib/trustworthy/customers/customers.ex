defmodule Trustworthy.Customers do
  @moduledoc """
  The Customers context.
  """

  import Ecto.Query, warn: false

  alias Trustworthy.CommandRouter
  alias Trustworthy.Customers.Commands

  @type uuid :: String.t()
  @type username :: String.t()

  @doc """
  Register a new user.
  """
  def register_user(attrs \\ %{}) do
    attrs
    |> Map.put(:user_uuid, UUID.uuid4())
    |> Commands.RegisterUser.new()
    |> CommandRouter.dispatch()
  end
end
