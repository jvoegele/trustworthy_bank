defmodule Trustworthy.Banking.Accounts do
  defprotocol AccountDetail do
    @moduledoc """
    Protocol defining operations on bank accounts.
    """

    alias FE.Result

    @doc "Deposit funds to an account."
    @spec deposit(t(), pos_integer()) :: Result.t(t())
    def deposit(account, amount)

    @doc "Withdraw funds from an account."
    @spec withdraw(t(), pos_integer()) :: Result.t(t())
    def withdraw(account, amount)

    @doc "Transfer money into an account."
    @spec transfer_in(t(), pos_integer()) :: Result.t(t())
    def transfer_in(account, amount)

    @doc "Transfer money out of an account."
    @spec transfer_out(t(), pos_integer()) :: Result.t(t())
    def transfer_out(account, amount)
  end
end
