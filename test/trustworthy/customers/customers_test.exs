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
    test "should fail with invalid data and return error" do
      assert {:error, :validation_failure, errors} =
               Customers.register_user(build(:user, username: ""))

      assert errors == %{username: ["is invalid"]}
    end
  end

  @tag :integration
  test "should fail when username already taken and return error" do
    assert {:ok, %User{}} = Customers.register_user(build(:user))
    assert {:error, :validation_failure, errors} = Customers.register_user(build(:user))
    assert errors == %{username: ["has already been taken"]}
  end

  @tag :integration
  test "should fail when registering identical username at same time and return error" do
    [success, failure] =
      1..2
      |> Enum.map(fn _ -> Task.async(fn -> Customers.register_user(build(:user)) end) end)
      |> Enum.map(&Task.await/1)
      |> Enum.sort()

    assert {:ok, %User{}} = success
    assert {:error, :validation_failure, errors} = failure

    assert errors == %{username: ["has already been taken"]}
  end

  @tag :integration
  test "should fail when username format is invalid and return error" do
    assert {:error, :validation_failure, errors} =
             Customers.register_user(build(:user, username: "j@son"))

    assert errors == %{username: ["is invalid"]}
  end

  @tag :integration
  test "should convert username to lowercase" do
    assert {:ok, %User{} = user} = Customers.register_user(build(:user, username: "JASON"))

    assert user.username == "jason"
  end

  @tag :integration
  test "should hash password" do
    params = build(:user)
    assert {:ok, %User{} = user} = Customers.register_user(params)
    assert Trustworthy.Auth.validate_password(params.password, user.hashed_password)
  end
end
