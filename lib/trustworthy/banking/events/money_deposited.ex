defmodule Trustworthy.Banking.Events.MoneyDeposited do
  @moduledoc """
  Event triggered by depositing money into an account.
  """

  @derive Jason.Encoder
  defstruct [:account_uuid, :account_type, :amount, :new_balance]
end
