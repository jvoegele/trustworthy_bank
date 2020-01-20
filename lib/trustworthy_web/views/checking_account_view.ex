defmodule TrustworthyWeb.CheckingAccountView do
  use TrustworthyWeb, :view
  alias TrustworthyWeb.CheckingAccountView

  def render("index.json", %{banking_checking_accounts: banking_checking_accounts}) do
    %{data: render_many(banking_checking_accounts, CheckingAccountView, "checking_account.json")}
  end

  def render("show.json", %{checking_account: checking_account}) do
    %{account: render_one(checking_account, CheckingAccountView, "checking_account.json")}
  end

  def render("checking_account.json", %{checking_account: checking_account}) do
    %{
      owner_uuid: checking_account.owner,
      balance: checking_account.balance,
      monthly_fee: checking_account.monthly_fee
    }
  end
end
