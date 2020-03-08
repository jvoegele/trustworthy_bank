defmodule Trustworthy.Customers.Events.UserRegistered do
  @moduledoc """
  Event triggered by new user registration.
  """

  alias Trustworthy.Customers

  @type t :: %__MODULE__{
          user_uuid: Customers.uuid(),
          username: Customers.username(),
          hashed_password: String.t()
        }

  @derive Jason.Encoder
  defstruct [:user_uuid, :username, :hashed_password]
end
