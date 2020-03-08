defmodule Trustworthy.Banking.Accounts.CheckingAccountDetail do
  @moduledoc """
  Account detail for checking accounts.
  """

  alias Trustworthy.Banking.Events.CheckingAccountOpened

  @derive Jason.Encoder
  defstruct balance: 0,
            monthly_fee: 0

  use ExConstructor

  def open(%CheckingAccountOpened{} = event) do
    %__MODULE__{
      balance: event.initial_balance,
      monthly_fee: event.monthly_fee
    }
  end

  defimpl Trustworthy.Banking.Accounts.AccountDetail do
    def deposit(%{balance: balance} = account, amount) do
      {:ok, %{account | balance: balance + amount}}
    end

    def withdraw(%{balance: balance} = account, amount) do
      {:ok, %{account | balance: balance - amount}}
    end

    def transfer_in(%{balance: balance} = account, amount) do
      {:ok, %{account | balance: balance + amount}}
    end

    def transfer_out(%{balance: balance} = account, amount) do
      {:ok, %{account | balance: balance - amount}}
    end
  end
end
