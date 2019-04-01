defmodule BankChallenge.Accounts.Projector do
  use Commanded.Projections.Ecto,
    name: "AccountProjector"

  alias BankChallenge.Accounts.Events, as: E
  alias BankChallenge.Accounts.Schemas, as: S
  
  project(%E.AccountOpened{} = evt, _metadata, fn multi ->
    Ecto.Multi.insert(multi, :account_opened, %S.Account{
      account_number: evt.account_number,
      username: evt.username,
      email: evt.email,
      hashed_password: evt.hashed_password,
      balance: evt.balance
    })
  end)

  project(%E.FundsAdded{} = evt, _metadada, fn _ ->
    Ecto.Multi.new
      |> Ecto.Multi.insert(:funds_added, %S.Transaction{
        transaction_number: evt.transaction_number,
        account_number: evt.account_number,
        name: "FundsAdded",
        amount: evt.amount})
      |> Ecto.Multi.insert(:account_balance_increase, %S.Account{
        account_number: evt.account_number, balance: evt.amount},
        conflict_target: :account_number,
        on_conflict: [inc: [balance: evt.amount]])
  end)

  project(%E.FundsRemoved{} = evt, _metadada, fn _ ->
    Ecto.Multi.new
      |> Ecto.Multi.insert(:funds_removed, %S.Transaction{
        transaction_number: evt.transaction_number,
        account_number: evt.account_number,
        name: "FundsRemoved",
        amount: evt.amount})
      |> Ecto.Multi.insert(:account_balance_decrease, %S.Account{
        account_number: evt.account_number, balance: evt.amount},
        conflict_target: :account_number,
        on_conflict: [inc: [balance: -evt.amount]])
  end)
end