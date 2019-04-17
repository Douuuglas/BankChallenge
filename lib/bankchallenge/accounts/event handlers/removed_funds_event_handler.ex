defmodule BankChallenge.Accounts.RemovedFundsEventHandler do
  use Commanded.Event.Handler, name: "RemoveFundsEventHandler", start_from: :origin

  alias BankChallenge.Accounts.Events, as: E
  alias BankChallenge.Accounts

  def handle(%E.FundsRemoved{} = evt, _metadata) do
    #send email
    IO.inspect(evt)
    email = Accounts.get_email_by_account(evt.account_number)
    IO.inspect("#{email}: saque de R$#{evt.amount} da sua conta")
    :ok
  end
end