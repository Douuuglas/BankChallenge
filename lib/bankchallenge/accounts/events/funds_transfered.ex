defmodule BankChallenge.Accounts.Events.FundsTransfered do
  @derive Jason.Encoder
  defstruct [
    :transaction_number,
    :account_number,
    :to_account_number,
    :amount
  ]
end