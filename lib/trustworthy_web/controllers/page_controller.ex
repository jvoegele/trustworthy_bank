defmodule TrustworthyWeb.PageController do
  use TrustworthyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
