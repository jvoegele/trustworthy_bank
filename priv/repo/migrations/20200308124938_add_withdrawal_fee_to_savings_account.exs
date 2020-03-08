defmodule Trustworthy.Repo.Migrations.AddWithdrawalFeeToSavingsAccount do
  use Ecto.Migration

  def change do
    alter table(:banking_savings_accounts) do
      add :withdrawal_fee, :integer
    end
  end
end
