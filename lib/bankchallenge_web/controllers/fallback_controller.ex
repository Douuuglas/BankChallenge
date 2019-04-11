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
    json = Jason.encode!(%{errors: "no funds"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(400, json)
  end

  def call(conn, {:error, :no_transfer_same_account}) do
    json = Jason.encode!(%{errors: "no transfer same account"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(400, json)
  end

  def call(conn, {:error, :account_not_found}) do
    json = Jason.encode!(%{errors: "account not found"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(400, json)
  end

  def call(conn, {:error, :username_already_exists}) do
    json = Jason.encode!(%{errors: "username already exists"})
    
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(400, json)
  end
end
