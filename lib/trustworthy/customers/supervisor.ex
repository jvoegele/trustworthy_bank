defmodule Trustworthy.Customers.Supervisor do
  @moduledoc """
  Supervisor for the Customers context.
  """
  use Supervisor

  alias Trustworthy.Customers

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init([Customers.Projectors.User], strategy: :one_for_one)
  end
end
