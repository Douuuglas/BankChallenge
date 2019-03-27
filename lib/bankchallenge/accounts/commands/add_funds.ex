defmodule BankChallenge.Accounts.Commands.AddFunds do
  defstruct [
    :transaction_number,
    :account_number,
    :amount
  ]
end