defmodule BankChallengeWeb.Router do
  use BankChallengeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BankChallengeWeb do
    pipe_through :api
  end
end
