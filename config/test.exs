use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :national_voter_file, NationalVoterFile.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :national_voter_file, NationalVoterFile.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "national_voter_file_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
