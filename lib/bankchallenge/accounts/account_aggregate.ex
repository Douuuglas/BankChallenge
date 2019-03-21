defmodule BankChallenge.Accounts.Aggregates.AccountAggregate do
  defstruct [
    :account_number,
    :username,
    :email,
    :hashed_password,
    :initial_balance,
  ]

  alias BankChallenge.Accounts.Aggregates.AccountAggregate
  alias BankChallenge.Accounts.Commands.OpenAccount
  alias BankChallenge.Accounts.Events.AccountOpened

  @doc """
  Criar uma nova conta
  """
  def execute(%AccountAggregate{account_number: nil}, %OpenAccount{} = open_account) do
    %AccountOpened{
      account_number: open_account.account_number,
      username: open_account.username,
      email: open_account.email,
      hashed_password: open_account.hashed_password,
      initial_balance: open_account.initial_balance
    }
  end

  @doc """
  Garantir que conta já não tenha sido criada
  """
  def execute(%AccountAggregate{}, %OpenAccount{}) do
    {:error, :account_already_opened}
  end

  @doc """
  Aplicar a mudança de estado
  """
  def apply(%AccountAggregate{} = account, %AccountOpened{} = opened_account) do
    %AccountAggregate{account |
      account_number: opened_account.account_number,
      username: opened_account.username,
      email: opened_account.email,
      hashed_password: opened_account.hashed_password,
      initial_balance: opened_account.initial_balance
    }
  end
end