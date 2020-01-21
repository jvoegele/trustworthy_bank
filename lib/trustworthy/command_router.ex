defmodule Trustworthy.CommandRouter do
  @moduledoc false

  use Commanded.Commands.Router,
    application: Trustworthy.App

  alias Trustworthy.Customers
  alias Trustworthy.Banking
  alias Trustworthy.Support.Middleware

  middleware Middleware.Validate
  middleware Middleware.Uniqueness

  dispatch [Customers.Commands.RegisterUser], to: Customers.Aggregates.User, identity: :user_uuid

  dispatch [Banking.Commands.OpenCheckingAccount], to: Banking.Aggregates.CheckingAccount, identity: :account_uuid
  dispatch [Banking.Commands.OpenSavingsAccount], to: Banking.Aggregates.SavingsAccount, identity: :account_uuid

  dispatch [Banking.Commands.DepositMoney.ToChecking], to: Banking.Aggregates.CheckingAccount, identity: :account_uuid
  dispatch [Banking.Commands.DepositMoney.ToSavings], to: Banking.Aggregates.SavingsAccount, identity: :account_uuid
end
