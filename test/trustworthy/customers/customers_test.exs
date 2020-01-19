defmodule Trustworthy.CustomersTest do
  use Trustworthy.DataCase

  alias Trustworthy.Customers
  alias Trustworthy.Customers.Projections.User

  describe "register user" do
    @tag :integration
    test "should succeed with valid data" do
      params = build(:user)
      assert {:ok, %User{} = user} = Customers.register_user(params)
      assert user.username == params.username
    end

    @tag :integration
    @tag :wip
    test "should fail with invalid data and return error" do
      assert {:error, :validation_failure, errors} =
               Customers.register_user(build(:user, username: ""))

      assert errors == %{username: ["is invalid"]}
    end
  end
end
