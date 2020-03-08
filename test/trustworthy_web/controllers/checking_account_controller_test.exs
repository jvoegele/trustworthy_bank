defmodule TrustworthyWeb.CheckingAccountControllerTest do
  use TrustworthyWeb.ConnCase

  @create_attrs %{
    customer_uuid: UUID.uuid4(),
    initial_balance: 10_000
  }

  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create checking_account" do
    @tag :web
    test "renders checking_account when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.checking_account_path(conn, :create), checking_account: @create_attrs)

      response = json_response(conn, 201)["account"]
      assert response["owner_uuid"] == @create_attrs.customer_uuid
      assert response["balance"] == @create_attrs.initial_balance
      assert is_integer(response["monthly_fee"])
    end

    @tag :web
    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.checking_account_path(conn, :create), checking_account: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
