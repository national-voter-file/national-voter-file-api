defmodule NationalVoterFile.Router do
  use NationalVoterFile.Web, :router
  use Plug.ErrorHandler
  use Sentry.Plug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :logging do
    plug Timber.ContextPlug
    plug Timber.EventPlug
  end

  pipeline :api do
    plug :accepts, ["json-api", "json"]
    plug JaSerializer.Deserializer
  end

  pipeline :bearer_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :current_user do
    plug NationalVoterFile.Plug.CurrentUser
    plug NationalVoterFile.Plug.SetSentryUserContext
  end

  scope "/", NationalVoterFile do
    pipe_through [:logging, :browser] # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/", NationalVoterFile, host: "api." do
    pipe_through [:logging, :api, :bearer_auth, :ensure_auth, :current_user]
  end

  scope "/", NationalVoterFile, host: "api." do
    pipe_through [:logging, :api, :bearer_auth, :current_user]

    post "/token", TokenController, :create
    post "/token/refresh", TokenController, :refresh

    resources "/users", UserController, only: [:index, :show, :create]
  end
end
