defmodule BankChallenge.Accounts.Commands.OpenAccount do
  @enforce_keys [:account_number]
  defstruct [
    :account_number,
    :username,
    :email,
    :hashed_password,
    :initial_balance
  ]
end