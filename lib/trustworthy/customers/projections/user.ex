defmodule Trustworthy.Customers.Projections.User do
  @moduledoc """
  Read model projection for users.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: false}
  @derive {Phoenix.Param, key: :uuid}
  schema "customers_users" do
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

  defmodule Query do
    @moduledoc false
    import Ecto.Query
    alias Trustworthy.Customers.Projections.User

    def by_username(username) do
      from u in User,
        where: u.username == ^username
    end
  end
end
