defmodule BankChallenge.Accounts.Commands.OpenAccount do
  defstruct [
    :account_number,
    :username,
    :email,
    :hashed_password,
    :balance
  ]
end