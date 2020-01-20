defmodule Trustworthy.Banking do
  @moduledoc """
  The Banking context.
  """

  alias Trustworthy.Repo
  alias Trustworthy.CommandRouter
  alias Trustworthy.Banking.Commands
  alias Trustworthy.Banking.Projections

  @spec open_checking_account(map()) :: {:ok, %Projections.CheckingAccount{}} | {:error, reason :: any()}
  def open_checking_account(attrs) do
    uuid = UUID.uuid4()

    attrs
    |> Map.merge(%{account_uuid: uuid, monthly_fee: 500})
    |> Commands.OpenCheckingAccount.new()
    |> CommandRouter.dispatch(consistency: :strong)
    |> case do
      :ok -> Repo.fetch(Projections.CheckingAccount, uuid)
      error -> error
    end
  end

  @spec open_savings_account(map()) :: {:ok, %Projections.SavingsAccount{}} | {:error, reason :: any()}
  def open_savings_account(attrs) do
    uuid = UUID.uuid4()

    attrs
    |> Map.merge(%{account_uuid: uuid, interest_rate: 0.05})
    |> Commands.OpenSavingsAccount.new()
    |> CommandRouter.dispatch(consistency: :strong)
    |> case do
      :ok -> Repo.fetch(Projections.SavingsAccount, uuid)
      error -> error
    end
  end
end
