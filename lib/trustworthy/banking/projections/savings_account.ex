defmodule Trustworthy.Banking.Projections.SavingsAccount do
  @moduledoc """
  Read model projection for savings accounts.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: false}
  @derive {Phoenix.Param, key: :uuid}
  schema "banking_savings_accounts" do
    field :owner, Ecto.UUID
    field :balance, :integer
    field :interest_rate, :decimal

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:owner, :balance, :interest_rate])
    |> validate_required([:owner, :balance])
  end
end
