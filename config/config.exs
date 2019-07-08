# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :live_view_test, LiveViewTestWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FrT1NiORVsvC8JULQLB4JnnDKxNq32ffvXHnlH5SV9XH/iYrCkKcnKj8huiOXwxj",
  render_errors: [view: LiveViewTestWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LiveViewTest.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :live_view_test, LiveViewTestWeb.Endpoint,
   live_view: [
     signing_salt: "X7+QiNizvQogW2O283KsJv+wql0OVJ6b"
   ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
