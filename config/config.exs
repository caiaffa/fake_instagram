# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :fake_instagram,
  ecto_repos: [FakeInstagram.Repo]

# Configures the endpoint
config :fake_instagram, FakeInstagramWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "G2Z9eFk+k0z5rTMmSGwtyF4zUz9TdyzwxnH0zcFEttyxI6sqvOrPybPYGWPsROVG",
  render_errors: [view: FakeInstagramWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: FakeInstagram.PubSub,
  live_view: [signing_salt: "ylOF/ppW"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures guardian
config :fake_instagram, FakeInstagramWeb.Auth.Guardian,
  issuer: "fake_instagram",
  verify_issuer: true,
  secret_key: "zl2Ohhgkc0UbCdGoSMV6lu0qx9NT5HrNK+eHxcK1yQ8jqtoQeFACWZyTGeb5WxiU"

# AWS
config :ex_aws,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  s3: [
    schema: "https://",
    host: "fakeinstagram-beta.s3.amazonaws.com",
    region: "us-east-1"
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
