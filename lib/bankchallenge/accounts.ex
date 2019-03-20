defmodule BankChallenge.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  
  alias BankChallenge.Repo
  alias BankChallenge.Accounts.Account
  alias BankChallenge.Accounts.Commands.OpenAccount
  alias BankChallenge.Accounts.Routers.AccountRouter
  alias BankChallenge.Accounts.Aggregates.AccountAggregate

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts do
    Repo.all(Account)
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
  def get_account!(account_number), do: Repo.get!(Account, account_number)

  @doc """
  Creates a account.

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %Account{}}

      iex> create_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account(attrs \\ %{}) do
    changeset = Account.changeset(%Account{}, attrs)
    
    if changeset.valid? do
      dispatch_result = %OpenAccount{
        account_number: changeset.changes.account_number,
        username: changeset.changes.username,
        email: changeset.changes.email,
        hashed_password: changeset.changes.hashed_password,
        initial_balance: changeset.changes.balance
      }
      |> AccountRouter.dispatch()

      case dispatch_result do
        :ok ->
          {
            :ok,
            %Account{
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

  @doc """
  Updates a account.

  ## Examples

      iex> update_account(account, %{field: new_value})
      {:ok, %Account{}}

      iex> update_account(account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
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
  def delete_account(%Account{} = account) do
    Repo.delete(account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account(account)
      %Ecto.Changeset{source: %Account{}}

  """
  def change_account(%Account{} = account) do
    Account.changeset(account, %{})
  end
end
