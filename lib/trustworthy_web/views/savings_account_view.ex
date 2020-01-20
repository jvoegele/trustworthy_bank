defmodule TrustworthyWeb.SavingsAccountView do
  use TrustworthyWeb, :view
  alias TrustworthyWeb.SavingsAccountView

  def render("index.json", %{banking_savings_accounts: banking_savings_accounts}) do
    %{data: render_many(banking_savings_accounts, SavingsAccountView, "savings_account.json")}
  end

  def render("show.json", %{savings_account: savings_account}) do
    %{account: render_one(savings_account, SavingsAccountView, "savings_account.json")}
  end

  def render("savings_account.json", %{savings_account: savings_account} = params) do
    %{
      owner_uuid: savings_account.owner,
      balance: savings_account.balance,
      interest_rate: Decimal.to_float(savings_account.interest_rate)
    }
  end
end
