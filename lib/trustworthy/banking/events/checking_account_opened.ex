defmodule Trustworthy.Banking.Events.CheckingAccountOpened do
  @moduledoc """
  Event triggered by opening a new checking account.
  """

  @type t :: %__MODULE__{
    account_uuid: Trustworthy.uuid(),
    owner_uuid: Trustworthy.uuid(),
    balance: non_neg_integer(),
    monthly_fee: non_neg_integer()
  }

  @derive Jason.Encoder
  defstruct [:account_uuid, :owner_uuid, :balance, :monthly_fee]
end
