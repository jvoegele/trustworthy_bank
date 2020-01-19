defmodule Trustworthy.Customers.User do
  @moduledoc """
  Read model projection for users.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: false}
  @derive {Phoenix.Param, key: :uuid}
  schema "users" do
    field :username, :string
    field :hashed_password, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :hashed_password])
    |> validate_required([:username, :hashed_password])
  end
end
