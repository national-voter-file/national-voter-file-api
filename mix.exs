defmodule NationalVoterFile.Mixfile do
  use Mix.Project

  def project do
    [app: :national_voter_file,
     version: "0.0.1",
     elixir: "~> 1.4.1",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     dialyzer: [plt_add_deps: :transitive],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps(),
     docs: docs(),
     test_coverage: [tool: ExCoveralls]]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {NationalVoterFile, []},
      applications: [
        :phoenix,
        :phoenix_pubsub,
        :phoenix_html,
        :cowboy,
        :logger,
        :gettext,
        :phoenix_ecto,
        :postgrex,
        :comeonin,
        :corsica,
        :ja_resource,
        :sentry,
        :timber
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.2.1"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.8"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.12"},
      {:cowboy, "~> 1.0"},
      {:canary, "~> 1.1"}, # Authorization
      {:comeonin, "~> 2.0"},
      {:corsica, "~> 0.4"}, # CORS
      {:credo, "~> 0.5", only: [:dev, :test]}, # Code style suggestions
      {:dialyxir, "~> 0.4", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.5", only: :test}, # Test coverage
      {:ex_doc, "~> 0.14", only: [:dev, :test]},
      {:ex_machina, "~> 1.0", only: :test}, # test factories
      {:guardian, "~> 0.13"}, # Authentication (JWT)
      {:inch_ex, "~> 0.5", only: [:dev, :test]}, # Inch CI
      {:ja_resource, "~> 0.2"},
      {:ja_serializer, "~> 0.11.0"}, # JSON API
      {:mix_test_watch, "~> 0.2", only: :dev}, # Test watcher
      {:sentry, "~> 2.0"}, # Sentry error tracking
      {:timber, "~> 0.4"} # Logging
    ]
  end

  defp docs do
    [
      extras: [
        "README.md": [title: "README"],
        "LICENSE.txt": [title: "LICENSE"]
      ],
      main: "README",
      source_url: "https://github.com/national-voter-file/national-voter-file-api"
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
