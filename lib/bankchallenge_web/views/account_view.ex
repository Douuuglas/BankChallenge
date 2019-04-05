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
      balance: account.balance,
  }
  end
end