defmodule Trustworthy.Auth do
  @moduledoc """
  Boundary for authentication.
  Uses the bcrypt password hashing function.
  """

  alias Comeonin.Bcrypt
  alias FE.Maybe

  alias Trustworthy.Customers
  alias Trustworthy.Customers.Projections.User

  def authenticate(username, password) do
    with {:ok, user} <- user_by_username(username) do
      check_password(user, password)
   end
  end

  def hash_password(password), do: Bcrypt.hashpwsalt(password)
  def validate_password(password, hash), do: Bcrypt.checkpw(password, hash)

  defp user_by_username(username) do
    username
    |> Customers.user_by_username()
    |> Maybe.to_result(:unauthenticated)
  end

  defp check_password(%User{hashed_password: hashed_password} = user, password) do
    case validate_password(password, hashed_password) do
      true -> {:ok, user}
      _ -> {:error, :unauthenticated}
    end
  end
end
