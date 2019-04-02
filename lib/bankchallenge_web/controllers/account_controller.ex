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
    with {:ok, %S.Account{} = account} <- Accounts.create_account(account_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.account_path(conn, :show, account))
      |> render("show.json", account: account)
    end
  end

  def show(conn, %{"account_number" => account_number}) do
    account = Accounts.get_account!(account_number)
    render(conn, "show.json", account: account)
  end

  def add_funds(conn, %{"add_funds" => add_funds_params}) do
    with {:ok, _} <- Accounts.add_funds(add_funds_params) do
      conn
      |> put_status(:created)
      |> send_resp(201, "ok")
    end
  end

  def remove_funds(conn, %{"remove_funds" => remove_funds_params}) do
    with {:ok, _} <- Accounts.remove_funds(remove_funds_params) do
      conn
      |> put_status(:created)
      |> send_resp(201, "ok")
    end
  end

  def transfer_funds(conn, %{"transfer_funds" => transfer_funds_params}) do
    with {:ok, _} <- Accounts.transfer_funds(transfer_funds_params) do
      conn
      |> put_status(:created)
      |> send_resp(201, "ok")
    end
  end
end
