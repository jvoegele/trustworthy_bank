use Mix.Config

# Configure the read store database
config :trustworthy, Trustworthy.Repo,
  username: "postgres",
  password: "postgres",
  database: "trustworthy_readstore_test",
  hostname: "localhost",
  pool_size: 1

# Configure the event store database
config :trustworthy, Trustworthy.EventStore,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "trustworthy_eventstore_test",
  hostname: "localhost",
  pool_size: 1

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :trustworthy, TrustworthyWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
