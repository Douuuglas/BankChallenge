defmodule BankChallenge.Accounts.Queries.EmailByAccountNumber do
  import Ecto.Query
  
  def new(account_number) do
    account_number = UUID.string_to_binary!(account_number)

    from a in "accounts",
    where: a.account_number == ^account_number,
    select: a.email
  end
end