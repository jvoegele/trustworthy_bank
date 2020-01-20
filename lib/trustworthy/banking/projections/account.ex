defmodule Trustworthy.Banking.Projections.Account do
  @moduledoc """
  Read model projection for bank accounts.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: false}
  @derive {Phoenix.Param, key: :uuid}
  schema "banking_accounts" do
    field :account_type, :string

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:account_type])
    |> validate_required([:account_type])
  end
end
