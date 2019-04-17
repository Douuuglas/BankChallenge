defmodule BankChallenge.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  
  alias BankChallenge.Repo
  alias BankChallenge.Accounts.Schemas, as: S
  alias BankChallenge.Accounts.Commands, as: C
  alias BankChallenge.Accounts.Routers, as: R
  alias BankChallenge.Accounts.Queries, as: Q
  
  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts do
    Repo.all(S.Account)
  end

  @doc """
  Gets a single account.

  Raises `Ecto.NoResultsError` if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account!(account_number), do: Repo.get!(S.Account, account_number)

  def get_email_by_account(account_number) do
    account_number
    |> Q.EmailByAccountNumber.new()
    |> Repo.all()
  end

  @doc """
  Creates a account.

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %Account{}}

      iex> create_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account(attrs \\ %{}) do
    changeset = S.Account.create_account_changeset(%S.Account{}, attrs)
    
    if changeset.valid? do
      case Repo.get_by(S.Account, username: changeset.changes.username) do
        nil ->
          dispatch_result = %C.OpenAccount{
            account_number: changeset.changes.account_number,
            username: changeset.changes.username,
            email: changeset.changes.email,
            hashed_password: changeset.changes.hashed_password,
            balance: changeset.changes.balance}
          |> R.Account.dispatch()
    
          case dispatch_result do
            :ok ->
              {:ok, get_account!(changeset.changes.account_number)}
            reply ->
              reply
          end
        _ ->
          {:error, :username_already_exists}
      end
    else
      {:error, changeset}
    end
  end

  def transfer_funds(attrs \\ %{}) do
    changeset = S.Transaction.transfer_funds_changeset(%S.Transaction{}, attrs)
    
    if changeset.valid? do
      case Repo.get(S.Account, changeset.changes.to_account_number) do
        nil ->
          {:error, :to_account_doenst_exists}
        _ ->
          dispatch_result = %C.TransferFunds{
            transaction_number: changeset.changes.transaction_number,
            account_number: changeset.changes.account_number,
            to_account_number: changeset.changes.to_account_number,
            amount: changeset.changes.amount}
          |> R.Account.dispatch
          
          case dispatch_result do
            :ok ->
              {:ok, get_account!(changeset.changes.account_number)}
            reply ->
              reply
          end
      end
    else
      {:error, changeset}
    end
  end

  def remove_funds(attrs \\ %{}) do
    changeset = S.Transaction.remove_funds_changeset(%S.Transaction{}, attrs)

    if changeset.valid? do
      dispatch_result = %C.RemoveFunds{
        transaction_number: changeset.changes.transaction_number,
        account_number: changeset.changes.account_number,
        amount: changeset.changes.amount}
      |> R.Account.dispatch

      case dispatch_result do
        :ok ->
          {:ok, get_account!(changeset.changes.account_number)}
        reply ->
          reply
      end
    else
      {:error, changeset}
    end
  end

  def add_funds(attrs \\ %{}) do
    changeset = S.Transaction.add_funds_changeset(%S.Transaction{}, attrs)
    
    if changeset.valid? do
      dispatch_result = %C.AddFunds{
        transaction_number: changeset.changes.transaction_number,
        account_number: changeset.changes.account_number,
        amount: changeset.changes.amount}
      |> R.Account.dispatch
      
      case dispatch_result do
        :ok ->
          {:ok, get_account!(changeset.changes.account_number)}
        reply ->
          reply
      end
    else
      {:error, changeset}
    end
  end
end
