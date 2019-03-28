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
      balance: evt.balance
    })
  end)

  project(%E.FundsAdded{} = evt, _metadada, fn _ ->
    Ecto.Multi.new
      |> Ecto.Multi.insert(:account_projector, %S.Transaction{
        transaction_number: evt.transaction_number,
        account_number: evt.account_number,
        name: "FundsAdded",
        amount: evt.amount})
  end)
end