defmodule Trustworthy.Customers.Commands.RegisterUser do
  @moduledoc """
  Command to register a new user.
  """

  alias Trustworthy.Customers

  @type t :: %__MODULE__{
    user_uuid: Customers.uuid(),
    username: Customers.username(),
    password: String.t(),
    hashed_password: String.t()
  }

  defstruct [:user_uuid, :username, :password, :hashed_password]

  use ExConstructor
end
