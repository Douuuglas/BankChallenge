defmodule BankChallengeWeb.SessionController do
  use BankChallengeWeb, :controller
  alias BankChallange.AccountManager

  def login(conn, %{"account" => %{"username" => username, "password" => password}}) do
    case AccountManager.authenticate_user(username, password) do
      {:ok, token, _claims} ->
        conn
        |> render("jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end
end