defmodule TrustworthyWeb.SessionControllerTest do
  use TrustworthyWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "authenticate user" do
    setup [
      :register_user
    ]

    @tag :web
    test "creates session and renders session when data is valid", %{conn: conn} do
      conn =
        post conn, Routes.session_path(conn, :create),
          user: %{
            username: "user",
            password: "p@ssw0rd123"
          }

      json = json_response(conn, 201)["user"]
      token = json["token"]

      assert json == %{
               "username" => "user",
               "token" => token
             }

      refute token == ""
    end

    @tag :web
    test "does not create session and renders errors when password does not match", %{conn: conn} do
      conn =
        post conn, Routes.session_path(conn, :create),
          user: %{
            username: "user",
            password: "invalidpassword"
          }

      assert json_response(conn, 422)["errors"] == %{
               "username or password" => [
                 "is invalid"
               ]
             }
    end

    @tag :web
    test "does not create session and renders errors when user not found", %{conn: conn} do
      conn =
        post conn, Routes.session_path(conn, :create),
          user: %{
            username: "doesnotexist",
            password: "p@ssw0rd123"
          }

      assert json_response(conn, 422)["errors"] == %{
               "username or password" => [
                 "is invalid"
               ]
             }
    end
  end
end
