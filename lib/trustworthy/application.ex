defmodule Trustworthy.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Commanded application
      Trustworthy.App,
      # Start the Ecto repository
      Trustworthy.Repo,
      # Start the endpoint when the application starts
      TrustworthyWeb.Endpoint,
      Trustworthy.Customers.Supervisor,
      Trustworthy.Support.Unique,
    ]

    opts = [strategy: :one_for_one, name: Trustworthy.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TrustworthyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
