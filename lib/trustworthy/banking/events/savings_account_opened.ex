defmodule Trustworthy.Banking.Events.SavingsAccountOpened do
  @moduledoc """
  Event triggered by opening a new savings account.
  """

  @derive Jason.Encoder
  defstruct [:account_uuid, :owner_uuid, :initial_balance, :interest_rate, :withdrawal_fee]
end
