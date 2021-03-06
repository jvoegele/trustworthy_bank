defmodule Trustworthy.Banking do
  @moduledoc """
  The Banking context.
  """

  alias Trustworthy.Repo
  alias Trustworthy.CommandRouter
  alias Trustworthy.Banking.Commands
  alias Trustworthy.Banking.Projections
  alias FE.Result
  alias FE.Maybe

  @spec open_checking_account(map()) :: Result.t(%Projections.CheckingAccount{})
  def open_checking_account(attrs) do
    uuid = UUID.uuid4()

    attrs
    |> Map.merge(%{account_uuid: uuid, monthly_fee: 500})
    |> Commands.OpenCheckingAccount.new()
    |> CommandRouter.dispatch(consistency: :strong)
    |> case do
      :ok -> Projections.CheckingAccount |> Repo.fetch(uuid) |> Maybe.to_result(:not_found)
      error -> error
    end
  end

  @spec open_savings_account(map()) :: Result.t(%Projections.SavingsAccount{})
  def open_savings_account(attrs) do
    uuid = UUID.uuid4()

    attrs
    |> Map.merge(%{account_uuid: uuid, interest_rate: 0.05})
    |> Commands.OpenSavingsAccount.new()
    |> CommandRouter.dispatch(consistency: :strong)
    |> case do
      :ok -> Projections.SavingsAccount |> Repo.fetch(uuid) |> Maybe.to_result(:not_found)
      error -> error
    end
  end

  @spec get_account(Trustworthy.uuid()) :: Maybe.t(Projections.Account.account())
  def get_account(account_uuid) do
    Projections.Account
    |> Repo.fetch(account_uuid)
    |> Maybe.and_then(&lookup_account/1)
  end

  @spec deposit(Trustworthy.uuid(), pos_integer()) :: Result.t(Projections.Account.account())
  def deposit(account_uuid, amount) do
    Commands.DepositMoney.new(%{account_uuid: account_uuid, amount: amount})
    |> CommandRouter.dispatch(consistency: :strong)
    |> case do
      :ok -> account_uuid |> get_account() |> Maybe.to_result(:not_found)
      error -> Result.error(error)
    end
  end

  def transfer(src_uuid, dest_uuid, amount) do
    %{source_account_uuid: src_uuid, destination_account_uuid: dest_uuid, amount: amount}
    |> Commands.TransferFunds.new()
    |> CommandRouter.dispatch()
  end

  defp lookup_account(%Projections.Account{uuid: uuid, account_type: account_type}) do
    projection =
      case account_type do
        "checking" -> Projections.CheckingAccount
        "savings" -> Projections.SavingsAccount
      end

    Repo.fetch(projection, uuid)
  end
end
