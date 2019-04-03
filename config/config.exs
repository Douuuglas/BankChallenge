# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bankchallenge,
  namespace: BankChallenge,
  ecto_repos: [BankChallenge.Repo]

# Configures the endpoint
config :bankchallenge, BankChallengeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Fb3mUtisg97txxQzZa57hQUf67GkjIIOnC3kS1PFxIWNedSRE1viLfu5mjutlyOa",
  render_errors: [view: BankChallengeWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: BankChallenge.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configurar o commanded
config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

# Configurar ecto
config :commanded_ecto_projections,
  repo: BankChallenge.Repo

# Configurar guardian
config :bankchallenge, BankChallenge.AccountManager.Guardian,
  issuer: "bankchallenge",
  secret_key: "6z8QDNlGXcuPirb18kQyQrkLpDm1tPV4mTNNtGPF2Oc8l7ugeUrO7/cCVjbX6WCa"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
