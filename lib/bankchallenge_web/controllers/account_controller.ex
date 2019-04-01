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

  def delete(conn, %{"account_number" => account_number}) do
    account = Accounts.get_account!(account_number)

    with {:ok, %S.Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end

  def add_funds(conn, %{"add_funds" => add_funds}) do
    with {:ok, %S.Transaction{} = add_funds} <- Accounts.add_funds(add_funds) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.account_path(conn, :show, add_funds))
      |> render("transaction.show.json", transaction: add_funds)
    end
  end

  def remove_funds(conn, %{"remove_funds" => remove_funds}) do
    with {:ok, %S.Transaction{} = remove_funds} <- Accounts.remove_funds(remove_funds) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.account_path(conn, :show, remove_funds))
      |> render("transaction.show.json", transaction: remove_funds)
    end
  end

  def transfer_funds(conn, %{"transfer_funds" => transfer_funds}) do
    with {:ok, %S.Transaction{} = transfer_funds} <- Accounts.transfer_funds(transfer_funds) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.account_path(conn, :show, transfer_funds))
      |> render("transaction.show.json", transaction: transfer_funds)
    end
  end
end
