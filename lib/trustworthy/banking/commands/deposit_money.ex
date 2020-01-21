defmodule Trustworthy.Banking.Commands.DepositMoney do
  @moduledoc """
  Command to deposit money to a bank account.
  """

  alias __MODULE__.ToChecking
  alias __MODULE__.ToSavings
  alias Trustworthy.Banking.Projections.CheckingAccount
  alias Trustworthy.Banking.Projections.SavingsAccount

  defmacro __using__(_opts) do
    quote do
      defstruct [:account_uuid, :amount]

      @type t :: %__MODULE__{
        account_uuid: Trustworthy.uuid(),
        amount: pos_integer()
      }

      use ExConstructor
      use Vex.Struct

      validates :account_uuid, uuid: true
      validates :amount, number: [greater_than: 0]
    end
  end

  def new(%CheckingAccount{}, params), do: ToChecking.new(params)
  def new(%SavingsAccount{}, params), do: ToSavings.new(params)
end

defmodule Trustworthy.Banking.Commands.DepositMoney.ToChecking do
  @moduledoc false
  use Trustworthy.Banking.Commands.DepositMoney
end

defmodule Trustworthy.Banking.Commands.DepositMoney.ToSavings do
  @moduledoc false
  use Trustworthy.Banking.Commands.DepositMoney
end

