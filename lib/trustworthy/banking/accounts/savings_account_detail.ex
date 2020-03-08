defmodule Trustworthy.Banking.Accounts.SavingsAccountDetail do
  @moduledoc """
  Account detail for savings accounts.
  """

  alias Trustworthy.Banking.Events.SavingsAccountOpened

  @derive Jason.Encoder
  defstruct balance: 0,
            interest_rate: 0.0,
            withdrawal_fee: 0

  use ExConstructor

  def open(%SavingsAccountOpened{} = event) do
    %__MODULE__{
      balance: event.initial_balance,
      interest_rate: event.interest_rate,
      withdrawal_fee: event.withdrawal_fee
    }
  end

  defimpl Trustworthy.Banking.Accounts.AccountDetail do
    def deposit(%{balance: balance} = account, amount) do
      {:ok, %{account | balance: balance + amount}}
    end

    def withdraw(%{balance: balance, withdrawal_fee: fee} = account, amount) do
      withdrawal_amount = amount + fee
      {:ok, %{account | balance: balance - withdrawal_amount}}
    end

    def transfer_in(%{balance: balance} = account, amount) do
      {:ok, %{account | balance: balance + amount}}
    end

    def transfer_out(%{balance: balance} = account, amount) do
      {:ok, %{account | balance: balance - amount}}
    end
  end
end
