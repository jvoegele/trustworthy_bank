defmodule Trustworthy.Banking.Supervisor do
  @moduledoc """
  Supervisor for the Banking context.
  """
  use Supervisor

  alias Trustworthy.Banking

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    children = [
      Banking.Projectors.Accounts,
      Banking.ProcessManagers.TransferFunds
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
