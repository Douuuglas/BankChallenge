defmodule BankChallenge.Accounts.AccountSupervisor do
  use Supervisor

  alias BankChallenge.Accounts

  def start_link do
    Supervisor.start_link(__MODULE__, nil)
  end

  def init(_arg) do
    children = [
      supervisor(Accounts.Projectors.AccountOpenedProjector,
      [],
      id: :account_opened)
    ]

    supervise(children, strategy: :one_for_one)
  end
end