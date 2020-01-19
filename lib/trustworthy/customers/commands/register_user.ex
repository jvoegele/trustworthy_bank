defmodule Trustworthy.Customers.Commands.RegisterUser do
  @moduledoc """
  Command to register a new user.
  """

  alias Trustworthy.Customers
  alias Trustworthy.Customers.Validators.UniqueUsername

  @type t :: %__MODULE__{
          user_uuid: Customers.uuid(),
          username: Customers.username(),
          password: String.t(),
          hashed_password: String.t()
        }

  defstruct [:user_uuid, :username, :password, :hashed_password]

  use ExConstructor
  use Vex.Struct

  validates :user_uuid, uuid: true

  validates :username,
    format: [with: ~r/^[a-z0-9]+$/, allow_nil: false, allow_blank: false, message: "is invalid"],
    string: true,
    by: &UniqueUsername.validate/2

  defimpl Trustworthy.Support.Middleware.Uniqueness.UniqueFields do
    def unique(%{user_uuid: user_uuid}),
      do: [
        {:username, "has already been taken", user_uuid}
      ]
  end

  def assign_uuid(%__MODULE__{} = command, uuid) when is_binary(uuid) do
    %{command | user_uuid: uuid}
  end

  def downcase_username(%__MODULE__{username: username} = command) when is_binary(username) do
    %{command | username: String.downcase(username)}
  end
end
