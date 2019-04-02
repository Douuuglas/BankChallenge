defmodule BankChallengeWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use BankChallengeWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BankChallengeWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(BankChallengeWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :no_funds}) do
    conn
    |> send_resp(400, "no funds")
  end

  def call(conn, {:error, :no_transfer_same_account}) do
    conn
    |> send_resp(400, "no transfer same account")
  end

  def call(conn, {:error, :account_not_found}) do
    conn
    |> send_resp(400, "account not found")
  end
end
