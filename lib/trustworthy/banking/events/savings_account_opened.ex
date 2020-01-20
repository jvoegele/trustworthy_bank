defmodule Trustworthy.Banking.Events.SavingsAccountOpened do
  @moduledoc """
  Event triggered by opening a new savings account.
  """

  @type t :: %__MODULE__{
    account_uuid: Trustworthy.uuid(),
    owner_uuid: Trustworthy.uuid(),
    balance: non_neg_integer(),
    interest_rate: non_neg_integer()
  }

  @derive Jason.Encoder
  defstruct [:account_uuid, :owner_uuid, :balance, :interest_rate]
end
