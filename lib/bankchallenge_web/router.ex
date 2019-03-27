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
    post "/accounts/add_funds", AccountController, :add_funds
    post "/accounts/remove_funds", AccountController, :remove_funds
    post "/accounts/transfer_funds", AccountController, :transfer_funds

    delete "/accounts/:account_number", AccountController, :delete
  end
end
