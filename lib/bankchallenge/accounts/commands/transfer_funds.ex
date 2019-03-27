defmodule BankChallenge.Accounts.Commands.TransferFunds do
  defstruct [
    :transaction_number,
    :account_number,
    :to_account_number,
    :amount
  ]
end