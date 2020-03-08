defmodule Trustworthy.Banking.Aggregates.AccountTest do
  use Trustworthy.AggregateCase, aggregate: Trustworthy.Banking.Aggregates.Account

  alias Trustworthy.Banking.{Accounts, Aggregates, Commands, Events}

  describe "deposit to checking account" do
    setup [:setup_checking_account]

    @tag :unit
    test "emits MoneyDeposited event when successful", %{checking_account: account} do
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
    test "emits MoneyDeposited event when successful", %{savings_account: account} do
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

  describe "transfer between accounts" do
    setup [:setup_checking_account, :setup_savings_account]

    @tag :unit
    test "emits FundsTransferRequested event when successful", %{
      checking_account: checking,
      savings_account: savings
    } do
      checking_uuid = checking.uuid
      savings_uuid = savings.uuid
      transfer_amount = 50

      command = %Commands.TransferFunds{
        source_account_uuid: checking_uuid,
        destination_account_uuid: savings_uuid,
        amount: transfer_amount
      }

      assert %Events.FundsTransferRequested{
               source_account_uuid: ^checking_uuid,
               destination_account_uuid: ^savings_uuid,
               amount: ^transfer_amount
             } = Aggregates.Account.execute(checking, command)
    end
  end

  describe "transfer funds in" do
    setup [:setup_checking_account]

    @tag :unit
    test "emits FundsTransferredIn event when successful", %{checking_account: account} do
      account_uuid = account.uuid
      command = %Commands.TransferFundsIn{account_uuid: account_uuid, amount: 200}
      amount = command.amount

      assert %Events.FundsTransferredIn{
               account_uuid: ^account_uuid,
               amount: ^amount,
               account_detail: %{balance: new_balance}
             } = Aggregates.Account.execute(account, command)

      assert new_balance == account.account_detail.balance + amount
    end
  end

  describe "transfer funds out" do
    setup [:setup_savings_account]

    @tag :unit
    test "emits FundsTransferredOut event when successful", %{savings_account: account} do
      account_uuid = account.uuid
      command = %Commands.TransferFundsOut{account_uuid: account_uuid, amount: 200}
      amount = command.amount

      assert %Events.FundsTransferredOut{
               account_uuid: ^account_uuid,
               amount: ^amount,
               account_detail: %{balance: new_balance}
             } = Aggregates.Account.execute(account, command)

      assert new_balance == account.account_detail.balance - amount
    end
  end

  defp setup_checking_account(_) do
    account = %Aggregates.Account{
      uuid: UUID.uuid4(),
      owner_uuid: UUID.uuid4(),
      account_detail: Accounts.CheckingAccountDetail.new(%{balance: 100})
    }

    {:ok, checking_account: account}
  end

  defp setup_savings_account(_) do
    account = %Aggregates.Account{
      uuid: UUID.uuid4(),
      owner_uuid: UUID.uuid4(),
      account_detail: Accounts.SavingsAccountDetail.new(%{balance: 100, withdrawal_fee: 50})
    }

    {:ok, savings_account: account}
  end
end
