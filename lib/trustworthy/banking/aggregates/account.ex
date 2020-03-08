defmodule Trustworthy.Banking.Aggregates.Account do
  @moduledoc """
  Aggregate representing a bank account.
  """

  alias Trustworthy.Banking.Aggregates.Account
  alias Trustworthy.Banking.{Accounts, Commands, Events}

  defstruct [:uuid, :owner_uuid, :account_detail]

  ## Command handlers

  def execute(%Account{uuid: nil}, %Commands.OpenCheckingAccount{} = command) do
    %Events.CheckingAccountOpened{
      account_uuid: command.account_uuid,
      owner_uuid: command.customer_uuid,
      initial_balance: command.initial_balance,
      monthly_fee: command.monthly_fee
    }
  end

  def execute(%Account{uuid: nil}, %Commands.OpenSavingsAccount{} = command) do
    %Events.SavingsAccountOpened{
      account_uuid: command.account_uuid,
      owner_uuid: command.customer_uuid,
      initial_balance: command.initial_balance,
      interest_rate: command.interest_rate,
      withdrawal_fee: command.withdrawal_fee
    }
  end

  def execute(%Account{uuid: uuid} = account, %Commands.DepositMoney{
        account_uuid: uuid,
        amount: amount
      })
      when is_integer(amount) do
    with true <- amount > 0,
         {:ok, detail} <- Accounts.AccountDetail.deposit(account.account_detail, amount) do
      %Events.MoneyDeposited{
        account_uuid: uuid,
        amount: amount,
        account_detail: detail
      }
    else
      false -> {:error, :invalid_deposit_amount}
      {:error, reason} -> {:error, reason}
    end
  end

  def execute(%Account{uuid: uuid}, %Commands.TransferFunds{source_account_uuid: uuid} = command) do
    %Events.FundsTransferRequested{
      transfer_uuid: UUID.uuid4(),
      source_account_uuid: uuid,
      destination_account_uuid: command.destination_account_uuid,
      amount: command.amount
    }
  end

  def execute(
        %Account{uuid: uuid} = account,
        %Commands.TransferFundsIn{account_uuid: uuid, amount: amount}
      ) do
    case Accounts.AccountDetail.transfer_in(account.account_detail, amount) do
      {:ok, detail} ->
        %Events.FundsTransferredIn{
          account_uuid: uuid,
          amount: amount,
          account_detail: detail
        }

      {:error, reason} ->
        {:error, reason}
    end
  end

  def execute(
        %Account{uuid: uuid} = account,
        %Commands.TransferFundsOut{account_uuid: uuid, amount: amount}
      ) do
    case Accounts.AccountDetail.transfer_out(account.account_detail, amount) do
      {:ok, detail} ->
        %Events.FundsTransferredOut{
          account_uuid: uuid,
          amount: amount,
          account_detail: detail
        }

      {:error, reason} ->
        {:error, reason}
    end
  end

  ## Event handlers

  def apply(%Account{uuid: nil} = account, %Events.CheckingAccountOpened{} = event) do
    %{
      account
      | uuid: event.account_uuid,
        owner_uuid: event.owner_uuid,
        account_detail: Accounts.CheckingAccountDetail.open(event)
    }
  end

  def apply(%Account{uuid: nil} = account, %Events.SavingsAccountOpened{} = event) do
    %{
      account
      | uuid: event.account_uuid,
        owner_uuid: event.owner_uuid,
        account_detail: Accounts.SavingsAccountDetail.open(event)
    }
  end

  def apply(%Account{uuid: uuid} = account, %Events.MoneyDeposited{account_uuid: uuid} = event) do
    %Account{account | account_detail: event.account_detail}
  end

  def apply(%Account{} = account, %Events.FundsTransferRequested{}) do
    account
  end

  def apply(
        %Account{uuid: uuid} = account,
        %Events.FundsTransferredIn{account_uuid: uuid} = event
      ) do
    %Account{account | account_detail: event.account_detail}
  end

  def apply(
        %Account{uuid: uuid} = account,
        %Events.FundsTransferredOut{account_uuid: uuid} = event
      ) do
    %Account{account | account_detail: event.account_detail}
  end
end
