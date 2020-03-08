defmodule Trustworthy.Banking.Events.FundsTransferRequested do
  @moduledoc """
  Event triggered when transferring funds between accounts.
  """

  @derive Jason.Encoder
  defstruct [:transfer_uuid, :source_account_uuid, :destination_account_uuid, :amount]
end
