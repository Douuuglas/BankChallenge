defmodule BankChallenge.AccountManager.CurrentAccount do
  import Plug.Conn
  import Guardian.Plug

  def init(opts), do: opts

  def call(conn, _opts) do
    current_account = current_resource(conn)
    assign(conn, :current_account, current_account)
  end
end