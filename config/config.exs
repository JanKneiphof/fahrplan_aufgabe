# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :fahrplan_db,
  ecto_repos: [FahrplanDb.Repo]

# Configures the endpoint
config :fahrplan_db, FahrplanDbWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "S9NNBLRG/JDJ+Pa0zGeekoS6lKeY8zI2pbYt7ZiJdXCCEBxPjd/OPAUuQqYw8QIx",
  render_errors: [view: FahrplanDbWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: FahrplanDb.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "IJB6IQ4R"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
