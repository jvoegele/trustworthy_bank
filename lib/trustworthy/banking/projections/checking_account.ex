defmodule Trustworthy.Banking.Projections.CheckingAccount do
  @moduledoc """
  Read model projection for checking accounts.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: false}
  @derive {Phoenix.Param, key: :uuid}
  schema "banking_checking_accounts" do
    field :owner, Ecto.UUID
    field :balance, :integer
    field :monthly_fee, :integer

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:owner, :balance, :monthly_fee])
    |> validate_required([:owner, :balance])
  end
end
