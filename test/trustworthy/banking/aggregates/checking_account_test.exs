defmodule Trustworthy.Banking.Aggregates.CheckingAccountTest do
  use Trustworthy.AggregateCase, aggregate: Trustworthy.Banking.Aggregates.CheckingAccount

  alias Trustworthy.Banking.Aggregates
  alias Trustworthy.Banking.Commands
  alias Trustworthy.Banking.Events

  setup [:setup_account]

  describe "deposit money" do
    @tag :unit
    test "emits MoneyDeposited event when successful", %{account: account} do
      command = %Commands.DepositMoney.ToChecking{account_uuid: account.uuid, amount: 200}

      assert Aggregates.CheckingAccount.execute(account, command) == %Events.MoneyDeposited{
               account_uuid: account.uuid,
               account_type: "checking",
               amount: command.amount,
               new_balance: account.balance + command.amount
             }
    end
  end

  defp setup_account(_) do
    account = %Aggregates.CheckingAccount{
      uuid: UUID.uuid4(),
      owner_uuid: UUID.uuid4(),
      balance: 100
    }

    {:ok, account: account}
  end
end
