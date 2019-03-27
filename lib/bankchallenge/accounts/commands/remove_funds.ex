defmodule BankChallenge.Accounts.Commands.RemoveFunds do
  defstruct [
    :transaction_number,
    :account_number,
    :amount
  ]
end