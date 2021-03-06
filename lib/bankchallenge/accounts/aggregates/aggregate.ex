defmodule BankChallenge.Accounts.Aggregates.Account do
  defstruct [
    :account_number,
    :username,
    :email,
    :hashed_password,
    :balance,
  ]

  alias BankChallenge.Accounts.Aggregates.Account
  alias BankChallenge.Accounts.Commands, as: C
  alias BankChallenge.Accounts.Events, as: E

  @doc """
  Criar uma nova conta
  """
  def execute(%Account{account_number: nil}, %C.OpenAccount{} = open_account) do
    %E.AccountOpened{
      account_number: open_account.account_number,
      username: open_account.username,
      email: open_account.email,
      hashed_password: open_account.hashed_password,
      balance: open_account.balance
    }
  end

  def execute(%Account{account_number: nil}, %C.AddFunds{}) do
    {:error, :account_not_found}
  end

  def execute(_, %C.AddFunds{} = add_funds) do
    %E.FundsAdded{
      transaction_number: add_funds.transaction_number,
      account_number: add_funds.account_number,
      amount: add_funds.amount
    }
  end

  def execute(%Account{account_number: nil}, %C.RemoveFunds{}) do
    {:error, :account_not_found}
  end

  def execute(%{balance: b}, %C.RemoveFunds{amount: a}) when a > b do
    {:error, :no_funds}
  end
  
  def execute(_, %C.RemoveFunds{} = remove_funds) do
    %E.FundsRemoved{
      transaction_number: remove_funds.transaction_number,
      account_number: remove_funds.account_number,
      amount: remove_funds.amount
    }
  end

  def execute(%{account_number: a}, %C.TransferFunds{to_account_number: ta}) when a === ta do
    {:error, :no_transfer_same_account}
  end
  
  def execute(%Account{account_number: nil}, %C.TransferFunds{}) do
    {:error, :account_not_found}
  end

  def execute(%{balance: b}, %C.TransferFunds{amount: a}) when a > b do
    {:error, :no_funds}    
  end
  
  def execute(_, %C.TransferFunds{} = transfer_funds) do
    %E.FundsTransfered{
      transaction_number: transfer_funds.transaction_number,
      account_number: transfer_funds.account_number,
      to_account_number: transfer_funds.to_account_number,
      amount: transfer_funds.amount
    }
  end

  @doc """
  Garantir que conta já não tenha sido criada
  """
  def execute(%Account{}, %C.OpenAccount{}) do
    {:error, :account_already_opened}
  end

  @doc """
  Aplicar a mudança de estado
  """
  def apply(%Account{} = account, %E.AccountOpened{} = opened_account) do
    %Account{account |
      account_number: opened_account.account_number,
      username: opened_account.username,
      email: opened_account.email,
      hashed_password: opened_account.hashed_password,
      balance: opened_account.balance
    }
  end

  def apply(s, %E.FundsTransfered{} = evt) do
    sum_funds(s, evt.amount)
  end

  def apply(s, %E.FundsAdded{} = evt) do
    sum_funds(s, evt.amount)
  end 

  def apply(s, %E.FundsRemoved{} = evt) do
    sum_funds(s, evt.amount)
  end 

  defp sum_funds(s, amount) do
    %Account{s |
      balance: s.balance + amount
    }
  end
end