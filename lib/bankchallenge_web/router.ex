defmodule BankChallengeWeb.Router do
  use BankChallengeWeb, :router

  # Our pipeline implements "maybe" authenticated. We'll use the `:ensure_auth` below for when we need to make sure someone is logged in.
  pipeline :auth do
    plug BankChallenge.AccountManager.Pipeline
  end

  # We use ensure_auth to fail if there is no one logged in
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
    plug BankChallenge.AccountManager.CurrentAccount
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BankChallengeWeb do
    pipe_through [:api, :auth]

    post "/account", AccountController, :create
    post "/account/login", SessionController, :login
  end

  scope "/api", BankChallengeWeb do
    pipe_through [:api, :auth, :ensure_auth]

    get "/account", AccountController, :show
    post "/account/add_funds", AccountController, :add_funds
    post "/account/remove_funds", AccountController, :remove_funds
    post "/account/transfer_funds", AccountController, :transfer_funds
    get "/accounts", AccountController, :index
  end
end
