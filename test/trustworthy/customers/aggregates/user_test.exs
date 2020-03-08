defmodule Trustworthy.Customers.Aggregates.UserTest do
  use Trustworthy.AggregateCase, aggregate: Trustworthy.Customers.Aggregates.User

  alias Trustworthy.Customers.Events.UserRegistered

  describe "register user" do
    @tag :unit
    test "should succeed when valid" do
      command = build(:register_user, user_uuid: UUID.uuid4())

      assert_events(command, [
        %UserRegistered{
          user_uuid: command.user_uuid,
          username: command.username,
          hashed_password: command.hashed_password
        }
      ])
    end
  end
end
