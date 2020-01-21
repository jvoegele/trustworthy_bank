defmodule Trustworthy.Customers.Validators.UniqueUsername do
  @moduledoc """
  Validator to ensure a username is unique.
  """

  use Vex.Validator

  alias Trustworthy.Customers
  alias FE.Maybe

  def validate(username, context) do
    user_uuid = Map.get(context, :user_uuid)

    case username_registered?(username, user_uuid) do
      true -> {:error, "has already been taken"}
      false -> :ok
    end
  end

  defp username_registered?(username, user_uuid) do
    username
    |> Customers.user_by_username()
    |> Maybe.unwrap_with(& &1.uuid != user_uuid, false)
  end
end
