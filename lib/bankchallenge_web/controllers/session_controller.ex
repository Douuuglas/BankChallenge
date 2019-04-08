defmodule BankChallengeWeb.SessionController do
  use BankChallengeWeb, :controller
  alias BankChallange.AccountManager

  def login(conn, %{"account" => %{"username" => username, "password" => password}}) do
    case AccountManager.authenticate_user(username, password) do
      {:ok, token, _claims} ->
        conn
        |> render("jwt.json", jwt: token)
      {:error, :invalid_credentials} ->
        conn
        |> render("invalid_credentials.json")
    end
  end
end