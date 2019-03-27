defmodule BankChallenge.Accounts.Events.FundsAdded do
  @derive Jason.Encoder
  defstruct [
    :account_number,
    :amount
  ]
end