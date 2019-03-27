defmodule BankChallenge.Accounts.Events.FundsRemoved do
  @derive Jason.Encoder
  defstruct [
    :account_number,
    :amount
  ]
end