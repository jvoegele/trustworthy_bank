defmodule Trustworthy.Storage do
  @moduledoc """
  Management of eventstore and readstore for the test environment.
  """

  @doc """
  Reset the event store and read store databases.
  """
  def reset! do
    :ok = Application.stop(:trustworthy)

    reset_eventstore!()
    reset_readstore!()

    {:ok, _} = Application.ensure_all_started(:trustworthy)
  end

  defp reset_eventstore! do
    {:ok, conn} =
      Trustworthy.EventStore.config()
      |> EventStore.Config.default_postgrex_opts()
      |> Postgrex.start_link()

    EventStore.Storage.Initializer.reset!(conn)
  end

  defp reset_readstore! do
    readstore_config = Application.get_env(:trustworthy, Trustworthy.Repo)

    {:ok, conn} = Postgrex.start_link(readstore_config)

    Postgrex.query!(conn, truncate_readstore_tables(), [])
  end

  defp truncate_readstore_tables do
    """
    TRUNCATE TABLE
      customers_users,
      projection_versions
    RESTART IDENTITY;
    """
  end
end
