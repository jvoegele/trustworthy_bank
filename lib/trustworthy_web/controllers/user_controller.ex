defmodule TrustworthyWeb.UserController do
  use TrustworthyWeb, :controller

  alias Trustworthy.Customers
  alias Trustworthy.Customers.Projections.User

  action_fallback TrustworthyWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Customers.register_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end
end
