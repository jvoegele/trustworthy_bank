defmodule Trustworthy.Customers.Projectors.User do
  @moduledoc """
  Projector for the `User` read model projection.
  """
  use Commanded.Projections.Ecto,
    application: Trustworthy.App,
    name: "Customers.Projectors.User",
    consistency: :strong

  alias Trustworthy.Customers.Events.UserRegistered
  alias Trustworthy.Customers.Projections.User

  project(%UserRegistered{} = registered, fn multi ->
    Ecto.Multi.insert(multi, :user, %User{
      uuid: registered.user_uuid,
      username: registered.username,
      hashed_password: registered.hashed_password
    })
  end)
end
