defmodule Trustworthy.Repo do
  use Ecto.Repo,
    otp_app: :trustworthy,
    adapter: Ecto.Adapters.Postgres

  @spec fetch(module(), any()) :: {:ok, any()} | {:error, :not_found}
  def fetch(schema, id) do
    case get(schema, id) do
      nil -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end
end
