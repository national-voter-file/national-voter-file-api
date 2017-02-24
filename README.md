# National Voter File API

We provide an easy-to-use, modern-era database with voter files for each of the fifty states. It uses a data model that represents a national voter file as well as associated campaign measures in a shared data warehouse.

We want to pull politics into the 21st century, and we're starting from the ground up.

### Goals

* Reliable, up-to-date voter data for every state in the country (including address changes, and redrawn districts)
* All available via an easy-to-consume REST API
* For thousands to use our voter file to power their campaigns' donation, canvassing, and phonebanking efforts!

## How does it work?

Glad you asked! Simple, we:

### 1. Collect voter files from every state

We've done nine states so far. We'd [love your help collecting them all](https://trello.com/b/IlZkwYc0/national-voter-file-states-pipeline).

### 2. Extract and transform that data

Each state does it differently, some (way) worse than others. Using well-tested, state-specific [transformer scripts](src/python/national_voter_file/transformers/README.md) written in Python, we turn them into consistent CSV files.

### 3. Load that data into a Postgres database

We load the data using [Pentaho](tools/README.md), and contain the database and its query layer [within Docker](docker/README.md) so that it is platform agnostic.

### 4. Build [a simple, accessible, easy-to-vend API](https://github.com/national-voter-file/national-voter-file-api) for consumers.

## This sounds awesome! How can I help?

* We chat on Slack. [Join us!](https://airtable.com/shraBEItZa0sYiMB0)
* Take a look at our [newcomer issues](https://github.com/national-voter-file/national-voter-file/projects/1) to see where you can help.

## Usage

- [How do I interact with the app?](#interacting-with-the-app)
- [How do I stop and start the server?](#stopping-and-starting-the-server)
- [How do I run tests?](#running-tests)
- [How do I lint the code?](#linting-code-with-credo)
- [Do I need special environment variables?](#environment)

### Interacting with the app

You'll generally interact with the app using `mix` tasks. You can [read the Phoenix documentation here](http://www.phoenixframework.org/docs/mix-tasks).

### Stopping and starting the server

To start the server, run `mix phoenix.server`.

To stop the server, hit `Ctrl+C` twice.

### Running tests

To run the tests you run `MIX_ENV=test mix test`.

### Linting Code with Credo

[Credo](https://github.com/rrrene/credo) is a static code analysis tool for Elixir. In general, we conform to the [Credo Style Guide](https://github.com/rrrene/elixir-style-guide) when writing Elixir code. You can run `mix credo` to check your code for design, readability, and consistency against this guide.

Credo's style guide is influenced by this more popular and exhaustive community [Elixir Style Guide](https://github.com/levionessa/elixir_style_guide). We defer to that guide where the Credo guide is ambiguous, e.g. [external module references](https://github.com/levionessa/elixir_style_guide#modules).

### Environment

When contributing to the app, you will not have access to secure environment variables required to run some tests or work on aspects of the app locally. Unfortunately, for security reasons, we cannot provide you with sandboxed keys for doing this on your own.

You can see these variables in `.env.example`.
