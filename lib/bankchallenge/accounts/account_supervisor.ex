defmodule BankChallenge.Accounts.AccountSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, nil)
  end

  def init(_arg) do
    children = [
      worker(Accounts.Projectors.AccountOpened, [], id: :account_opened)
    ]

    supervise(children, strategy: :one_for_one)
  end
end