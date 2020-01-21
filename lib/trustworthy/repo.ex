defmodule Trustworthy.Repo do
  use Ecto.Repo,
    otp_app: :trustworthy,
    adapter: Ecto.Adapters.Postgres

  alias FE.Maybe

  @spec fetch(module(), any()) :: Maybe.t(any())
  def fetch(schema, id) do
    Maybe.new(get(schema, id))
  end
end
