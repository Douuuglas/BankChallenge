defmodule BankChallenge.Accounts.Projectors.AccountOpenedProjector do
  use Commanded.Projections.Ecto,
    name: "Accounts.Projectors.AccountOpened"

  alias BankChallenge.Accounts.Events.AccountOpened
  alias BankChallenge.Accounts.Projectors.AccountProjector

  project(%AccountOpened{} = evt, _metadata, fn multi ->
    Ecto.Multi.insert(multi, :account_opened, %AccountProjector{
      account_number: evt.account_number,
      username: evt.username,
      email: evt.email,
      hashed_password: evt.hashed_password,
      balance: evt.balance
    })
  end)
end