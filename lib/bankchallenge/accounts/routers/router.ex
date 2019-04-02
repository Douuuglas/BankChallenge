defmodule BankChallenge.Accounts.Routers.Account do
  use Commanded.Commands.Router

  alias BankChallenge.Accounts.Aggregates, as: A
  alias BankChallenge.Accounts.Commands, as: C
  
  dispatch([
    C.OpenAccount,
    C.AddFunds,
    C.RemoveFunds,
    C.TransferFunds,
    ],
    to: A.Account,
    identity: :account_number)
end