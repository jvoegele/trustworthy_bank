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

  describe "open savings account" do
    @tag :integration
    test "opens new savings account when given valid data" do
      params = %{customer_uuid: UUID.uuid4(), initial_balance: 100 * 100}
      assert {:ok, %Projections.SavingsAccount{} = account} = Banking.open_savings_account(params)
      assert account.owner == params.customer_uuid
      assert account.balance == 100 * 100
    end
  end

  describe "get_account/1" do
    @tag :integration
    test "returns CheckingAccount projection when account_uuid is for a checking account" do
      uuid = UUID.uuid4()
      insert(:banking_account, uuid: uuid)
      insert(:checking_account, uuid: uuid)
      assert {:just, %Projections.CheckingAccount{} = account} = Banking.get_account(uuid)
      assert account.uuid == uuid
    end

    @tag :integration
    test "returns SavingsAccount projection when account_uuid is for a savings account" do
      uuid = UUID.uuid4()
      insert(:banking_account, uuid: uuid, account_type: "savings")
      insert(:savings_account, uuid: uuid)
      assert {:just, %Projections.SavingsAccount{} = account} = Banking.get_account(uuid)
      assert account.uuid == uuid
    end

    @tag :integration
    test "returns :nothing if no account is found" do
      uuid = UUID.uuid4()
      assert Banking.get_account(uuid) == :nothing
    end

    @tag :integration
    test "returns :nothing if account has the incorrect type" do
      uuid = UUID.uuid4()
      insert(:banking_account, uuid: uuid, account_type: "savings")
      insert(:checking_account, uuid: uuid)
      assert Banking.get_account(uuid) == :nothing
    end
  end

  describe "deposit" do
    @tag :integration
    test "updates checking account balance" do
      params = %{customer_uuid: UUID.uuid4(), initial_balance: 100_000}
      {:ok, %Projections.CheckingAccount{} = account} = Banking.open_checking_account(params)
      assert {:ok, account} = Banking.deposit(account.uuid, 10_000)
      assert account.balance == params.initial_balance + 10_000
    end

    @tag :integration
    test "updates savings account balance" do
      params = %{customer_uuid: UUID.uuid4(), initial_balance: 100_000}
      {:ok, %Projections.SavingsAccount{} = account} = Banking.open_savings_account(params)
      assert {:ok, account} = Banking.deposit(account.uuid, 10_000)
      assert account.balance == params.initial_balance + 10_000
    end
  end
end
