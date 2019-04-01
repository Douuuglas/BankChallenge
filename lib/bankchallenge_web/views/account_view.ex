defmodule BankChallengeWeb.AccountView do
  use BankChallengeWeb, :view
  alias BankChallengeWeb.AccountView

  def render("index.json", %{accounts: accounts}) do
    %{data: render_many(accounts, AccountView, "account.json")}
  end

  def render("show.json", %{account: account}) do
    %{data: render_one(account, AccountView, "account.json")}
  end

  def render("account.json", %{account: account}) do
    %{
      account_number: account.account_number,
      username: account.username,
      email: account.email,
      hashed_password: account.hashed_password,
      balance: account.balance,
  }
  end

  def render("transaction.show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, AccountView, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{
      transaction_number: transaction.transaction_number,
      name: transaction.name,
      account_number: transaction.account_number,
      to_account_number: transaction.to_account_number,
      amount: transaction.amount,
  }
  end
end
