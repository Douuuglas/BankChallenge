defmodule BankChallenge.Accounts.Events.FundsRemoved do
  @derive Jason.Encoder
  defstruct [
    :transaction_number,
    :account_number,
    :amount
  ]
end