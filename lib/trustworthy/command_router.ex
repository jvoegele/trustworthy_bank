defmodule Trustworthy.CommandRouter do
  @moduledoc false

  use Commanded.Commands.Router,
    application: Trustworthy.App

  alias Trustworthy.Customers.Commands.RegisterUser
  alias Trustworthy.Customers.Aggregates.User
  alias Trustworthy.Banking.Commands.OpenCheckingAccount
  alias Trustworthy.Banking.Aggregates.CheckingAccount

  middleware Trustworthy.Support.Middleware.Validate
  middleware Trustworthy.Support.Middleware.Uniqueness

  dispatch [RegisterUser], to: User, identity: :user_uuid
  dispatch [OpenCheckingAccount], to: CheckingAccount, identity: :account_uuid
end
