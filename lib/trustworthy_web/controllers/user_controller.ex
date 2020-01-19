defmodule TrustworthyWeb.UserController do
  use TrustworthyWeb, :controller

  alias Trustworthy.Customers
  alias Trustworthy.Customers.Projections.User

  action_fallback TrustworthyWeb.FallbackController
  plug Guardian.Plug.EnsureAuthenticated when action in [:current]

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Customers.register_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def current(conn, _params) do
    user = Trustworthy.Auth.Guardian.Plug.current_resource(conn)
    jwt = Trustworthy.Auth.Guardian.Plug.current_token(conn)

    conn
    |> put_status(:ok)
    |> render("show.json", user: user, jwt: jwt)
  end
end
