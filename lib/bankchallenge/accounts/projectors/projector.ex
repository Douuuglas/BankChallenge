defmodule BankChallenge.Accounts.Projector do
  use Commanded.Projections.Ecto,
    name: "AccountProjector"

  alias BankChallenge.Accounts.Events, as: E
  alias BankChallenge.Accounts.Schemas, as: S
  
  project(%E.AccountOpened{} = evt, _metadata, fn multi ->
    Ecto.Multi.insert(multi, :account_projector, %S.Account{
      account_number: evt.account_number,
      username: evt.username,
      email: evt.email,
      hashed_password: evt.hashed_password,
      balance: Decimal.new(evt.balance)
    })
  end)

  project(%E.FundsAdded{} = evt, _metadada, fn multi ->
    Ecto.Multi.insert(multi, :account_projector, %S.Account{
      balance: Decimal.new(evt.amount)
    })
  end)
end