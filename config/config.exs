# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :disscuss,
  ecto_repos: [Disscuss.Repo]

# Configures the endpoint
config :disscuss, DisscussWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: DisscussWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Disscuss.PubSub,
  live_view: [signing_salt: "Vg6WywlL"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :disscuss, Disscuss.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

config :ueberauth, Ueberauth,
providers: [
  github: {Ueberauth.Strategy.Github, [default_scope: "user:email"]}
]

client_secret =
  System.get_env("GITHUB_CLIENT_SECRET") ||
    raise """
    environment variable CLIENT_SECRET is missing.
    """
client_id =
  System.get_env("GITHUB_CLIENT_ID") ||
    raise """
    environment variable CLIENT_ID is missing.
    """
#     # "7edae2006fd8e2cc5301b56094e126dbaf2ae0a2"
config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: client_id,
  client_secret: client_secret
