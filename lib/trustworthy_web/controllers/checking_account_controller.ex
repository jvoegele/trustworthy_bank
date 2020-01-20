defmodule TrustworthyWeb.CheckingAccountController do
  use TrustworthyWeb, :controller

  alias Trustworthy.Banking
  alias Trustworthy.Banking.Projections.CheckingAccount

  action_fallback TrustworthyWeb.FallbackController

  def create(conn, %{"checking_account" => checking_account_params}) do
    with {:ok, %CheckingAccount{} = checking_account} <- Banking.open_checking_account(checking_account_params) do
      conn
      |> put_status(:created)
      |> render("show.json", checking_account: checking_account)
    end
  end
end
