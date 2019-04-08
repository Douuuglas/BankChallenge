defmodule BankChallengeWeb.AccountControllerTest do
  use BankChallengeWeb.ConnCase

  alias BankChallenge.Accounts

  @create_attrs %{
    username: "aline",
    email: "aline.guesser@gmail.com",
    password: "senha"
  }

  @invalid_attrs %{
    username: nil,
    email: nil,
    password: nil
  }

  def fixture(:account) do
    {:ok, account} = Accounts.create_account(@create_attrs)
    account
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all accounts without authentication", %{conn: conn} do
      conn = get(conn, Routes.account_path(conn, :index))
      assert json_response(conn, 401)["errors"] == "unauthenticated"
    end
  end

  describe "create account" do
    test "renders account when data is valid", %{conn: conn} do
      conn = post(conn, Routes.account_path(conn, :create), account: @create_attrs)
      
      assert %{"account" => account} = json_response(conn, 201)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.account_path(conn, :create), account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "account add funds" do
    def add_funds(conn, %{"add_funds" => add_funds_params}) do
      with {:ok, _} <- Accounts.add_funds(add_funds_params) do
        conn
        |> put_status(:created)
        |> send_resp(201, "ok")
      end
    end
    
  end
  
  describe "account remove funds" do
    def remove_funds(conn, %{"remove_funds" => remove_funds_params}) do
      with {:ok, _} <- Accounts.remove_funds(remove_funds_params) do
        conn
        |> put_status(:created)
        |> send_resp(201, "ok")
      end
    end    
  end

  describe "account transfer funds" do
    def transfer_funds(conn, %{"transfer_funds" => transfer_funds_params}) do
      with {:ok, _} <- Accounts.transfer_funds(transfer_funds_params) do
        conn
        |> put_status(:created)
        |> send_resp(201, "ok")
      end
    end
  end
end
