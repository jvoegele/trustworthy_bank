defmodule Trustworthy.Customers.Validators.UniqueUsername do
  @moduledoc """
  Validator to ensure a username is unique.
  """

  use Vex.Validator

  alias Trustworthy.Customers
  alias Trustworthy.Customers.Projections.User

  def validate(username, context) do
    user_uuid = Map.get(context, :user_uuid)

    case username_registered?(username, user_uuid) do
      true -> {:error, "has already been taken"}
      false -> :ok
    end
  end

  defp username_registered?(username, user_uuid) do
    case Customers.user_by_username(username) do
      %User{uuid: ^user_uuid} -> false
      nil -> false
      _ -> true
    end
  end
end
