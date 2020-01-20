defmodule Trustworthy.Banking.Projectors.Accounts do
  @moduledoc """
  Projector for the banking accounts read model projections.
  """

  use Commanded.Projections.Ecto,
    application: Trustworthy.App,
    name: "Banking.Projectors.Accounts",
    consistency: :strong

  alias Trustworthy.Banking.{Events, Projections}

  project %Events.CheckingAccountOpened{} = event, fn multi ->
    multi
    |> Ecto.Multi.insert(:account, %Projections.Account{uuid: event.account_uuid, account_type: "checking"})
    |> Ecto.Multi.insert(:checking, %Projections.CheckingAccount{
      uuid: event.account_uuid,
      owner: event.owner_uuid,
      balance: event.balance,
      monthly_fee: event.monthly_fee
    })
  end
end
