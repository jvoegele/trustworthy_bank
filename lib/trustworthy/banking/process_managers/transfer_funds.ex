defmodule Trustworthy.Banking.ProcessManagers.TransferFunds do
  @moduledoc false

  use Commanded.ProcessManagers.ProcessManager,
    application: Trustworthy.App,
    name: "Banking.ProcessManagers.TransferFunds"

  alias Trustworthy.Banking.{Commands, Events}

  @derive Jason.Encoder
  defstruct [
    :transfer_uuid,
    :source_account_uuid,
    :destination_account_uuid,
    :amount
  ]

  def interested?(%Events.FundsTransferRequested{transfer_uuid: transfer_uuid}),
    do: {:start!, transfer_uuid}

  def interested?(_event), do: false

  @spec handle(any, any) :: [
          %{
            __struct__:
              Trustworthy.Banking.Commands.TransferFundsIn
              | Trustworthy.Banking.Commands.TransferFundsOut,
            account_uuid: any,
            amount: any
          }
        ]
  def handle(%__MODULE__{}, %Events.FundsTransferRequested{} = event) do
    transfer_in_command = %Commands.TransferFundsIn{
      account_uuid: event.destination_account_uuid,
      amount: event.amount
    }

    transfer_out_command = %Commands.TransferFundsOut{
      account_uuid: event.source_account_uuid,
      amount: event.amount
    }

    [transfer_in_command, transfer_out_command]
  end

  def apply(%__MODULE__{} = pm, %Events.FundsTransferRequested{} = event) do
    %__MODULE__{
      pm
      | transfer_uuid: event.transfer_uuid,
        source_account_uuid: event.source_account_uuid,
        destination_account_uuid: event.destination_account_uuid,
        amount: event.amount
    }
  end
end
