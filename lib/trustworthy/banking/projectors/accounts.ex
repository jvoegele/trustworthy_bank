defmodule Trustworthy.Banking.Projectors.Accounts do
  @moduledoc """
  Projector for the banking accounts read model projections.
  """

  use Commanded.Projections.Ecto,
    application: Trustworthy.App,
    name: "Banking.Projectors.Accounts",
    consistency: :strong

  alias Trustworthy.Banking.{Events, Projections}
  alias Ecto.Multi

  project %Events.CheckingAccountOpened{} = event, fn multi ->
    multi
    |> Multi.insert(:account, %Projections.Account{uuid: event.account_uuid, account_type: "checking"})
    |> Multi.insert(:checking, %Projections.CheckingAccount{
      uuid: event.account_uuid,
      owner: event.owner_uuid,
      balance: event.balance,
      monthly_fee: event.monthly_fee
    })
  end

  project %Events.SavingsAccountOpened{} = event, fn multi ->
    multi
    |> Multi.insert(:account, %Projections.Account{uuid: event.account_uuid, account_type: "savings"})
    |> Multi.insert(:savings, %Projections.SavingsAccount{
      uuid: event.account_uuid,
      owner: event.owner_uuid,
      balance: event.balance,
      interest_rate: event.interest_rate
    })
  end

  project %Events.MoneyDeposited{} = event, fn multi ->
    projection =
      case event.account_type do
        "checking" -> Projections.CheckingAccount
        "savings" -> Projections.SavingsAccount
      end

    account = Trustworthy.Repo.get(projection, event.account_uuid)
    Multi.update(multi, :update_balance, Ecto.Changeset.change(account, balance: event.new_balance))
  end
end
