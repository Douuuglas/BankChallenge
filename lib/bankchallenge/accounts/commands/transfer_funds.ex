defmodule BankChallenge.Accounts.Commands.TransferFunds do
  defstruct [
    :from_account_number,
    :to_account_number,
    :amount
  ]
end