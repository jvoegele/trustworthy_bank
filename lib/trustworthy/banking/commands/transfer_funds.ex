defmodule Trustworthy.Banking.Commands.TransferFunds do
  @moduledoc """
  Command to transfer funds from a source account to a destination account.
  """

  defstruct [:source_account_uuid, :destination_account_uuid, :amount]

  use ExConstructor
  use Vex.Struct

  validates :source_account_uuid, uuid: true
  validates :destination_account_uuid, uuid: true
  validates :amount, number: [greater_than: 0]
end
