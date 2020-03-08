defmodule Trustworthy.Banking.Aggregates.AccountTest do
  use Trustworthy.AggregateCase, aggregate: Trustworthy.Banking.Aggregates.Account

  alias Trustworthy.Banking.{Accounts, Aggregates, Commands, Events}

  describe "deposit to checking account" do
    setup [:setup_checking_account]

    @tag :unit
    test "emits MoneyDeposited event when successful", %{account: account} do
      command = %Commands.DepositMoney{account_uuid: account.uuid, amount: 200}
      account_uuid = account.uuid
      amount = command.amount

      assert %Events.MoneyDeposited{
               account_uuid: ^account_uuid,
               amount: ^amount,
               account_detail: %{balance: new_balance}
      } = Aggregates.Account.execute(account, command)

      assert new_balance == account.account_detail.balance + amount
    end
  end

  describe "deposit to savings account" do
    setup [:setup_savings_account]

    @tag :unit
    test "emits MoneyDeposited event when successful", %{account: account} do
      command = %Commands.DepositMoney{account_uuid: account.uuid, amount: 200}
      account_uuid = account.uuid
      amount = command.amount

      assert %Events.MoneyDeposited{
               account_uuid: ^account_uuid,
               amount: ^amount,
               account_detail: %{balance: new_balance}
      } = Aggregates.Account.execute(account, command)

      assert new_balance == account.account_detail.balance + amount
    end
  end

  defp setup_checking_account(_) do
    account = %Aggregates.Account{
      uuid: UUID.uuid4(),
      owner_uuid: UUID.uuid4(),
      account_detail: Accounts.CheckingAccountDetail.new(%{balance: 100})
    }

    {:ok, account: account}
  end

  defp setup_savings_account(_) do
    account = %Aggregates.Account{
      uuid: UUID.uuid4(),
      owner_uuid: UUID.uuid4(),
      account_detail: Accounts.SavingsAccountDetail.new(%{balance: 100})
    }

    {:ok, account: account}
  end
end
