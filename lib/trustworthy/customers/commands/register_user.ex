defmodule Trustworthy.Customers.Commands.RegisterUser do
  @moduledoc """
  Command to register a new user.
  """

  alias Trustworthy.Auth
  alias Trustworthy.Customers
  alias Trustworthy.Customers.Validators.UniqueUsername

  @type t :: %__MODULE__{
          user_uuid: Customers.uuid(),
          username: Customers.username(),
          password: String.t() | nil,
          hashed_password: String.t()
        }

  defstruct [:user_uuid, :username, :password, :hashed_password]

  use ExConstructor
  use Vex.Struct

  @doc """
  Override `new/2` generated by `ExConstructor` to apply data transformations.
  """
  def new(attrs, opts) do
    attrs
    |> super(opts)
    |> downcase_username()
    |> hash_password()
  end

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

  @doc """
  Assign a unique identity for the user
  """
  def assign_uuid(%__MODULE__{} = command, uuid) when is_binary(uuid) do
    %{command | user_uuid: uuid}
  end

  @doc """
  Convert username to lowercase characters
  """
  def downcase_username(%__MODULE__{username: username} = command) when is_binary(username) do
    %{command | username: String.downcase(username)}
  end

  @doc """
  Hash the password, clear the original password
  """
  def hash_password(%__MODULE__{password: password} = register_user) do
    %{register_user | password: nil, hashed_password: Auth.hash_password(password)}
  end
end
