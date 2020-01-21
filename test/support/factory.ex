defmodule Trustworthy.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: Trustworthy.Repo

  alias Trustworthy.Banking

  def user_factory do
    %{
      uuid: UUID.uuid4(),
      username: "user",
      password: "p@ssw0rd123",
      hashed_password: "1fb9c14e934b825a62d15230cc0c2bd1",
    }
  end

  def register_user_factory do
    struct(Trustworthy.Customers.Commands.RegisterUser, build(:user))
  end

  def banking_account_factory do
    %Banking.Projections.Account{
      uuid: UUID.uuid4(),
      account_type: "checking"
    }
  end

  def checking_account_factory do
    %Banking.Projections.CheckingAccount{
      uuid: UUID.uuid4(),
      owner: UUID.uuid4(),
      balance: 100 * 100,
      monthly_fee: 500
    }
  end

  def savings_account_factory do
    %Banking.Projections.SavingsAccount{
      uuid: UUID.uuid4(),
      owner: UUID.uuid4(),
      balance: 100 * 100,
      interest_rate: 0.05
    }
  end
end
