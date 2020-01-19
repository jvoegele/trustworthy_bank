defmodule TrustworthyWeb.ConnHelpers do
  import Plug.Conn
  import Trustworthy.Fixture

  alias TrustworthyWeb.JWT

  def authenticated_conn(conn) do
    with {:ok, user} <- fixture(:user) do
      authenticated_conn(conn, user)
    end
  end

  def authenticated_conn(conn, user) do
    with {:ok, jwt} <- JWT.generate_jwt(user) do
      put_req_header(conn, "authorization", "Token " <> jwt)
    end
  end
end
