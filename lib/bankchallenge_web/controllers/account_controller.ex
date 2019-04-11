defmodule BankChallengeWeb.AccountController do
  use BankChallengeWeb, :controller

  alias BankChallenge.Accounts
  alias BankChallenge.Accounts.Schemas, as: S

  action_fallback BankChallengeWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, "index.json", accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %S.Account{} = acc} <- Accounts.create_account(account_params) do
      conn
      |> put_status(:created)
      |> render("show.json", account: acc)
    end
  end

  def show(conn, _params) do
    case Accounts.get_account!(conn.assigns.current_account.account_number) do
      nil ->
        {:error, :account_not_found}
      acc ->
        conn
        |> put_status(:ok)
        |> render("show.json", account: acc)
    end
  end

  def add_funds(conn, %{"add_funds" => add_funds_params}) do
    with {:ok, %S.Account{} = acc} <- Accounts.add_funds(add_funds_params) do
      conn
      |> put_status(:ok)
      |> render("show.json", account: acc)
    end
  end

  def remove_funds(conn, %{"remove_funds" => remove_funds_params}) do
    with {:ok, %S.Account{} = acc} <- Accounts.remove_funds(remove_funds_params) do
      conn
      |> put_status(:ok)
      |> render("show.json", account: acc)
    end
  end

  def transfer_funds(conn, %{"transfer_funds" => transfer_funds_params}) do
    with {:ok, %S.Account{} = acc} <- Accounts.transfer_funds(transfer_funds_params) do
      conn
      |> put_status(:ok)
      |> render("show.json", account: acc)
    end
  end
end
