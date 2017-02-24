# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :national_voter_file,
  ecto_repos: [NationalVoterFile.Repo]

# Configures the endpoint
config :national_voter_file, NationalVoterFile.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+G1gy7fVCEHF4rg9NJqGY5W80Td1LyEKFTUyBMTwFMwvg1QbkFytb3pUBUxiTBTD",
  render_errors: [view: NationalVoterFile.ErrorView, accepts: ~w(html json)],
  pubsub: [name: NationalVoterFile.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
