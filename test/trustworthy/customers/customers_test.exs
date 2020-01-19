defmodule Trustworthy.CustomersTest do
  use Trustworthy.DataCase

  alias Trustworthy.Customers
  alias Trustworthy.Customers.Aggregates.User

  describe "register user" do
    @tag :integration
    test "should succeed with valid data" do
      params = build(:user)
      assert {:ok, %User{} = user} = Customers.register_user(params)
      assert user.username == params.username
    end

    @tag :integration
    test "should fail with invalid data and return error" do
      assert {:error, :validation_failure, errors} = Customers.register_user(build(:user, username: ""))
      assert errors == %{username: ["can't be empty"]}
    end
  end


  describe "users" do
    alias Trustworthy.Customers.User

    @valid_attrs %{hashed_password: "some hashed_password", username: "some username"}
    @update_attrs %{hashed_password: "some updated hashed_password", username: "some updated username"}
    @invalid_attrs %{hashed_password: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Customers.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Customers.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Customers.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Customers.create_user(@valid_attrs)
      assert user.hashed_password == "some hashed_password"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customers.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Customers.update_user(user, @update_attrs)
      assert user.hashed_password == "some updated hashed_password"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Customers.update_user(user, @invalid_attrs)
      assert user == Customers.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Customers.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Customers.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Customers.change_user(user)
    end
  end
end
