defmodule Trustworthy.BankingTest do
  use Trustworthy.DataCase

  alias Trustworthy.Banking
  alias Trustworthy.Banking.Projections

  describe "open checking account" do
    @tag :integration
    test "opens new checking account when given valid data" do
      params = %{customer_uuid: UUID.uuid4(), initial_balance: 100 * 100}
      assert {:ok, %Projections.CheckingAccount{} = account} = Banking.open_checking_account(params)
      assert account.owner == params.customer_uuid
      assert account.balance == 100 * 100
    end
  end
end
