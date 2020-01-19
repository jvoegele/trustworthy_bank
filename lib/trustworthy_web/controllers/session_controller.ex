defmodule TrustworthyWeb.SessionController do
  use TrustworthyWeb, :controller

  alias Trustworthy.Auth
  alias Trustworthy.Customers.Projections.User

  action_fallback(TrustworthyWeb.FallbackController)

  def create(conn, %{"user" => %{"username" => username, "password" => password}}) do
    with {:ok, %User{} = user} <- Auth.authenticate(username, password),
         {:ok, jwt} <- generate_jwt(user) do
      conn
      |> put_status(:created)
      |> put_view(TrustworthyWeb.UserView)
      |> render("show.json", user: user, jwt: jwt)
    else
      {:error, :unauthenticated} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(TrustworthyWeb.ValidationView)
        |> render("error.json",
          errors: %{"username or password" => ["is invalid"]}
        )
    end
  end
end
