defmodule Trustworthy.Banking.Events.FundsTransferredOut do
  @moduledoc """
  Event triggered by transferring funds out of an account.
  """

  @derive Jason.Encoder
  defstruct [:account_uuid, :amount, :account_detail]
end
