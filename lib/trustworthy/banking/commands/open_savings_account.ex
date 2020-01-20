defmodule Trustworthy.Banking.Commands.OpenSavingsAccount do
  @moduledoc """
  Command to open a new savings account.
  """

  defstruct [:customer_uuid, :account_uuid, :initial_balance, :interest_rate]

  @type t :: %__MODULE__{
    customer_uuid: Trustworthy.uuid(),
    account_uuid: Trustworthy.uuid(),
    initial_balance: non_neg_integer(),
    interest_rate: float()
  }

  use ExConstructor
  use Vex.Struct

  validates :customer_uuid, uuid: true

  validates :account_uuid, uuid: true

  validates :initial_balance, number: [greater_than_or_equal_to: 0]
end
