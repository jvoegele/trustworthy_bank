defmodule Trustworthy.Banking.Events.FundsTransferredIn do
  @moduledoc """
  Event triggered by transferring funds into an account.
  """

  @derive Jason.Encoder
  defstruct [:account_uuid, :amount, :account_detail]
end
