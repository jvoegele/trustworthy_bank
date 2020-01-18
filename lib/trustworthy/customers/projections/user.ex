defmodule Trustworthy.Customers.User do
  @moduledoc """
  Read model projection for users.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :hashed_password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :hashed_password])
    |> validate_required([:username, :hashed_password])
  end
end
