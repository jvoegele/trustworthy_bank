defmodule Trustworthy.Repo.Migrations.CreateBankingSavingsAccountsTable do
  use Ecto.Migration

  def change do
    create table(:banking_savings_accounts, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :owner, :uuid, null: false
      add :balance, :integer, null: false
      add :interest_rate, :decimal

      timestamps()
    end
  end
end
