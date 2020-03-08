defmodule Trustworthy.Banking.Commands.OpenCheckingAccount do
  @moduledoc """
  Command to open a new checking account.
  """

  defstruct [:customer_uuid, :account_uuid, :initial_balance, :monthly_fee]

  use ExConstructor
  use Vex.Struct

  validates :customer_uuid, uuid: true
  validates :account_uuid, uuid: true
  validates :initial_balance, number: [greater_than_or_equal_to: 0]
end
