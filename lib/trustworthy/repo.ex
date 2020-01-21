defmodule Trustworthy.Repo do
  use Ecto.Repo,
    otp_app: :trustworthy,
    adapter: Ecto.Adapters.Postgres

  alias FE.Result

  @spec fetch(module(), any()) :: Result.t(any(), :not_found)
  def fetch(schema, id) do
    case get(schema, id) do
      nil -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end
end
