defmodule BankChallenge.Accounts.Events.FundsAdded do
  @derive Jason.Encoder
  defstruct [
    :transaction_number,
    :account_number,
    :amount
  ]
end