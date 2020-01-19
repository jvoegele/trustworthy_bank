defmodule TrustworthyWeb.UserView do
  use TrustworthyWeb, :view
  alias TrustworthyWeb.UserView

  def render("index.json", %{users: users}) do
    %{users: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user, jwt: jwt}) do
    %{user: user |> render_one(UserView, "user.json") |> Map.merge(%{token: jwt})}
  end

  def render("show.json", %{user: user}) do
    %{user: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{username: user.username}
  end
end
