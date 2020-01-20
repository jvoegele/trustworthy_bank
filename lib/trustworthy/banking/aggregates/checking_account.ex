defmodule Trustworthy.Banking.Aggregates.CheckingAccount do
  @moduledoc """
  The `CheckingAccount` aggregate.
  """

  alias Trustworthy.Banking.{Commands, Events}

  defstruct [:uuid, :owner_uuid, :balance, :monthly_fee]

  @type t :: %__MODULE__{
    uuid: Trustworthy.uuid(),
    owner_uuid: Trustworthy.uuid(),
    balance: integer(),
    monthly_fee: non_neg_integer()
  }

  def execute(%__MODULE__{uuid: nil}, %Commands.OpenCheckingAccount{} = command) do
    %Events.CheckingAccountOpened{
      account_uuid: command.account_uuid,
      owner_uuid: command.customer_uuid,
      balance: command.initial_balance,
      monthly_fee: command.monthly_fee
    }
  end

  def apply(%__MODULE__{} = account, %Events.CheckingAccountOpened{} = event) do
    %{account |
      uuid: event.account_uuid,
      owner_uuid: event.owner_uuid,
      balance: event.balance,
      monthly_fee: event.monthly_fee
    }
  end
end
