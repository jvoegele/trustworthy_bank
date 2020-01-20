defmodule Trustworthy.Repo.Migrations.CreateBankingCheckingAccountsTable do
  use Ecto.Migration

  def change do
    create table(:banking_checking_accounts, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :owner, :uuid, null: false
      add :balance, :integer, null: false
      add :monthly_fee, :integer

      timestamps()
    end
  end
end
