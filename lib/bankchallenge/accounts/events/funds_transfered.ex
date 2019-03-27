defmodule BankChallenge.Accounts.Events.FundsTransfered do
  @derive Jason.Encoder
  defstruct [
    :from_account_number,
    :to_account_number,
    :amount
  ]
end