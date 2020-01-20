defmodule TrustworthyWeb.SavingsAccountController do
  use TrustworthyWeb, :controller

  alias Trustworthy.Banking
  alias Trustworthy.Banking.Projections

  action_fallback TrustworthyWeb.FallbackController

  def create(conn, %{"savings_account" => savings_account_params}) do
    with {:ok, %Projections.SavingsAccount{} = savings_account} <-
           Banking.open_savings_account(savings_account_params) do
      conn
      |> put_status(:created)
      |> render("show.json", savings_account: savings_account)
    end
  end
end
