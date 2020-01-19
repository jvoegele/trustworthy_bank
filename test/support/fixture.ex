defmodule Trustworthy.Fixture do
  import Trustworthy.Factory

  alias Trustworthy.Customers

  def register_user(_context) do
    {:ok, user} = fixture(:user)

    [
      user: user
    ]
  end

  def fixture(:user, attrs \\ []) do
    build(:user, attrs) |> Customers.register_user()
  end
end
