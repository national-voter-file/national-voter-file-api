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
  username: System.get_env("DATABASE_POSTGRESQL_USERNAME") || "postgres",
  password: System.get_env("DATABASE_POSTGRESQL_PASSWORD") || "postgres",
  hostname: System.get_env("DATABASE_POSTGRESQL_HOST") || "localhost",
  database: "national_voter_file_phoenix_test",
  pool: Ecto.Adapters.SQL.Sandbox

# speed up password hashing
config :comeonin, :bcrypt_log_rounds, 4
config :comeonin, :pbkdf2_rounds, 1

# CORS allowed origins
config :national_voter_file, allowed_origins: ["http://localhost:4200"]

config :guardian, Guardian,
  secret_key: "753b8d2ff4e404c00efe81855fef134fa6a2817fd5c18d286b324e6b5b7e5219"

# Set Corsica logging to output no console warning when rejecting a request
config :national_voter_file, :corsica_log_level, [rejected: :debug]

config :sentry,
  environment_name: Mix.env || :test
