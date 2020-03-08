defmodule Trustworthy.Customers.Aggregates.User do
  @moduledoc """
  The `User` aggregate.
  """

  alias Trustworthy.Customers
  alias Trustworthy.Customers.Commands.RegisterUser
  alias Trustworthy.Customers.Events.UserRegistered

  defstruct [:uuid, :username, :hashed_password]

  @type t :: %__MODULE__{
          uuid: Customers.uuid(),
          username: Customers.username(),
          hashed_password: String.t()
        }

  @doc """
  Register a new user
  """
  def execute(%__MODULE__{uuid: nil}, %RegisterUser{} = command) do
    %UserRegistered{
      user_uuid: command.user_uuid,
      username: command.username,
      hashed_password: command.hashed_password
    }
  end

  def apply(%__MODULE__{} = user, %UserRegistered{} = event) do
    %__MODULE__{
      user
      | uuid: event.user_uuid,
        username: event.username,
        hashed_password: event.hashed_password
    }
  end
end
