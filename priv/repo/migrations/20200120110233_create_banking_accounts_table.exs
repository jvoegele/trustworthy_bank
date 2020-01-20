defmodule Trustworthy.Repo.Migrations.CreateBankingAccountsTable do
  use Ecto.Migration

  def change do
    create table(:banking_accounts, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :account_type, :string, null: false

      timestamps()
    end
  end
end
