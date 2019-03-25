defmodule BankChallengeWeb.Router do
  use BankChallengeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BankChallengeWeb do
    pipe_through :api

    get "/accounts", AccountController, :index
    get "/accounts/:account_number", AccountController, :show
    post "/accounts", AccountController, :create
    put "/accounts/:account_number", AccountController, :update
    delete "/accounts/:account_number", AccountController, :delete
  end
end
