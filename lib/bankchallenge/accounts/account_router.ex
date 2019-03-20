defmodule BankChallenge.Accounts.Routers.AccountRouter do
  use Commanded.Commands.Router

  alias BankChallenge.Accounts.Aggregates.AccountAggregate
  alias BankChallenge.Accounts.Commands.OpenAccount

  dispatch OpenAccount, to: AccountAggregate, identity: :account_number
end