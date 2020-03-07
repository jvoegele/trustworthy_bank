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

  def execute(%__MODULE__{uuid: uuid} = account, %Commands.DepositMoney.ToChecking{account_uuid: uuid, amount: amount}) do
    if is_integer(amount) and amount > 0 do
      %Events.MoneyDeposited{
        account_uuid: uuid,
        account_type: "checking",
        amount: amount,
        new_balance: account.balance + amount
      }
    else
      {:error, :invalid_deposit_amount}
    end
  end

  def execute(%__MODULE__{}, %Commands.DepositMoney.ToChecking{}) do
    {:error, :checking_account_not_found}
  end

  def apply(%__MODULE__{} = account, %Events.CheckingAccountOpened{} = event) do
    %{account |
      uuid: event.account_uuid,
      owner_uuid: event.owner_uuid,
      balance: event.balance,
      monthly_fee: event.monthly_fee
    }
  end

  def apply(%__MODULE__{uuid: uuid} = account, %Events.MoneyDeposited{account_uuid: uuid} = event) do
    %__MODULE__{account | balance: event.new_balance}
  end
end
