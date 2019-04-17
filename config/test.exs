use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bankchallenge, BankChallengeWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :bankchallenge, BankChallenge.Repo,
  username: "postgres",
  password: "postgres",
  database: "bankchallenge_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configuração de BD da EventStore
config :eventstore, EventStore.Storage,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "bankchallenge_eventstore_dev",
  hostname: "localhost",
  pool_size: 10