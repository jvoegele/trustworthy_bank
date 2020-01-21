defmodule Trustworthy.Banking.Commands.OpenCheckingAccount do
  @moduledoc """
  Command to open a new checking account.
  """

  defstruct [:customer_uuid, :account_uuid, :initial_balance, :monthly_fee]

  @type t :: %__MODULE__{
    customer_uuid: Trustworthy.uuid(),
    account_uuid: Trustworthy.uuid(),
    initial_balance: non_neg_integer(),
    monthly_fee: non_neg_integer()
  }

  use ExConstructor
  use Vex.Struct

  validates :customer_uuid, uuid: true
  validates :account_uuid, uuid: true
  validates :initial_balance, number: [greater_than_or_equal_to: 0]
end
