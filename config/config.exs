# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :expay,
  ecto_repos: [Expay.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :expay, ExpayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JmNbsX1Qh9dGMMryQbfouq9FQIRykS/24HR2yjflAg/iuihAXnHX9RiFQ2Vo/YWT",
  render_errors: [view: ExpayWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Expay.PubSub,
  live_view: [signing_salt: "WPF6ESD1"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
