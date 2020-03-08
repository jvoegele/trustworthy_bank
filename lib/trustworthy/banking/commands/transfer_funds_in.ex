defmodule Trustworthy.Banking.Commands.TransferFundsIn do
  @moduledoc """
  Command to transfer funds into a bank account.
  """

  defstruct [:account_uuid, :amount]

  use ExConstructor
  use Vex.Struct

  validates :account_uuid, uuid: true
  validates :amount, number: [greater_than: 0]
end
