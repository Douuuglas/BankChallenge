defmodule BankChallenge.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  
  alias BankChallenge.Repo
  alias BankChallenge.Accounts.Schema, as: S
  alias BankChallenge.Accounts.Commands, as: C
  alias BankChallenge.Accounts.Routers, as: R
  
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

  @doc """
  Creates a account.

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %Account{}}

      iex> create_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account(attrs \\ %{}) do
    changeset = S.Account.changeset(%S.Account{}, attrs)
    
    if changeset.valid? do
      dispatch_result = %C.OpenAccount{
        account_number: changeset.changes.account_number,
        username: changeset.changes.username,
        email: changeset.changes.email,
        hashed_password: changeset.changes.hashed_password,
        balance: changeset.changes.balance
      }
      |> R.Account.dispatch()

      case dispatch_result do
        :ok ->
          {
            :ok,
            %S.Account{
              account_number: changeset.changes.account_number,
              username: changeset.changes.username,
              email: changeset.changes.email,
              hashed_password: changeset.changes.hashed_password,
              balance: changeset.changes.balance
            }
          }
        reply -> reply
      end
    else
      {:validation_error, changeset}
    end
  end

  def transfer_funds(from_account_number, to_account_number, amount) do
    %C.TransferFunds{
      from_account_number: from_account_number,
      to_account_number: to_account_number,
      amount: amount
    }
    |> R.Account.dispatch
  end

  def remove_funds(account_number, amount) do
    %C.RemoveFunds{
      account_number: account_number,
      amount: amount
    }
    |> R.Account.dispatch
  end

  def add_funds(account_number, amount) do
    %C.AddFunds{
      account_number: account_number,
      amount: amount
    }
    |> R.Account.dispatch
  end

  def get_balance(account_number) do
    case Repo.get(Account, account_number) do
      nil ->
        {:error, :not_found}
      account ->
        {:ok, account.balance}
    end
  end

  @doc """
  Updates a account.

  ## Examples

      iex> update_account(account, %{field: new_value})
      {:ok, %Account{}}

      iex> update_account(account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account(%S.Account{} = account, attrs) do
    account
    |> S.Account.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Account.

  ## Examples

      iex> delete_account(account)
      {:ok, %Account{}}

      iex> delete_account(account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account(%S.Account{} = account) do
    Repo.delete(account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account(account)
      %Ecto.Changeset{source: %Account{}}

  """
  def change_account(%S.Account{} = account) do
    S.Account.changeset(account, %{})
  end
end
