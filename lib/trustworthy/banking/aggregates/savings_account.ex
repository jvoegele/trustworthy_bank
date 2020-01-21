defmodule Trustworthy.Banking.Aggregates.SavingsAccount do
  @moduledoc """
  The `SavingsAccount` aggregate.
  """

  alias Trustworthy.Banking.{Commands, Events}

  defstruct [:uuid, :owner_uuid, :balance, :interest_rate]

  @type t :: %__MODULE__{
    uuid: Trustworthy.uuid(),
    owner_uuid: Trustworthy.uuid(),
    balance: integer(),
    interest_rate: float()
  }

  def execute(%__MODULE__{uuid: nil}, %Commands.OpenSavingsAccount{} = command) do
    %Events.SavingsAccountOpened{
      account_uuid: command.account_uuid,
      owner_uuid: command.customer_uuid,
      balance: command.initial_balance,
      interest_rate: command.interest_rate
    }
  end

  def execute(%__MODULE__{uuid: uuid} = account, %Commands.DepositMoney.ToSavings{account_uuid: uuid, amount: amount} = command) do
    if is_integer(amount) and amount > 0 do
      %Events.MoneyDeposited{
        account_uuid: uuid,
        account_type: "savings",
        amount: command.amount,
        new_balance: account.balance + amount
      }
    else
      {:error, :invalid_deposit_amount}
    end
  end

  def execute(%__MODULE__{}, %Commands.DepositMoney.ToSavings{}) do
    {:error, :savings_account_not_found}
  end

  def apply(%__MODULE__{} = account, %Events.SavingsAccountOpened{} = event) do
    %{account |
      uuid: event.account_uuid,
      owner_uuid: event.owner_uuid,
      balance: event.balance,
      interest_rate: event.interest_rate
    }
  end

  def apply(%__MODULE__{uuid: uuid} = account, %Events.MoneyDeposited{account_uuid: uuid} = event) do
    %__MODULE__{account | balance: event.new_balance}
  end
end
