defmodule BankChallenge.Accounts.Events.AccountOpened do
  @derive Jason.Encoder
  defstruct [
    :account_number,
    :username,
    :email,
    :hashed_password,
    :initial_balance
  ]
end