defmodule Trustworthy.Banking.Events.CheckingAccountOpened do
  @moduledoc """
  Event triggered by opening a new checking account.
  """

  @derive Jason.Encoder
  defstruct [:account_uuid, :owner_uuid, :initial_balance, :monthly_fee]
end
