defmodule Trustworthy.Repo do
  use Ecto.Repo,
    otp_app: :trustworthy,
    adapter: Ecto.Adapters.Postgres
end
