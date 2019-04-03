defmodule BankChallengeWeb.Router do
  use BankChallengeWeb, :router

  # Our pipeline implements "maybe" authenticated. We'll use the `:ensure_auth` below for when we need to make sure someone is logged in.
  pipeline :auth do
    plug BankChallenge.AccountManager.Pipeline
  end

  # We use ensure_auth to fail if there is no one logged in
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BankChallengeWeb do
    pipe_through [:api, :auth]

    post "/accounts", AccountController, :create
    post "/accounts/login", SessionController, :login
  end

  scope "/api", BankChallengeWeb do
    pipe_through [:api, :auth, :ensure_auth]

    get "/accounts", AccountController, :index
    get "/accounts/:account_number", AccountController, :show
    post "/accounts/add_funds", AccountController, :add_funds
    post "/accounts/remove_funds", AccountController, :remove_funds
    post "/accounts/transfer_funds", AccountController, :transfer_funds
  end
end
