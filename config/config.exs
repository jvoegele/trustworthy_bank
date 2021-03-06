# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :trustworthy,
  ecto_repos: [Trustworthy.Repo],
  event_stores: [Trustworthy.EventStore]

config :trustworthy, Trustworthy.App,
  event_store: [
    adapter: Commanded.EventStore.Adapters.EventStore,
    event_store: Trustworthy.EventStore
  ],
  pub_sub: :local,
  registry: :local

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :commanded_ecto_projections,
  repo: Trustworthy.Repo

config :vex,
  sources: [
    Trustworthy.Support.Validators,
    Trustworthy.Customers.Validators,
    Vex.Validators
  ]

# Configures the endpoint
config :trustworthy, TrustworthyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6/zfPW2Ec+p2k9ltMCIFPqEXi7JJ3eA8Lui9YGdCUTV35yn0m32jGusZj1XUWa7P",
  render_errors: [view: TrustworthyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Trustworthy.PubSub, adapter: Phoenix.PubSub.PG2]

config :trustworthy, Trustworthy.Auth.Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "Trustworthy",
  ttl: {30, :days},
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key: "7RcI1arUWB5BcLbv8D/0SgXswBLPF5rj14XueNJGOvuJ0fGw3NGHvt8mnO+T9JGZ"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
