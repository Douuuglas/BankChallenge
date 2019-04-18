defmodule BankChallengeWeb.ReportController do
  use BankChallengeWeb, :controller

  action_fallback BankChallengeWeb.FallbackController

  def index(conn, _params) do
    all_events =
      EventStore.stream_all_forward()
      |> Stream.filter(fn ev -> ev.data.account_number == conn.assigns.current_account.account_number end)
      |> Stream.map(fn ev -> 
          balance = Map.get(ev.data, :balance)
          amount = Map.get(ev.data, :amount)

          if Map.get(ev.data, :balance) == nil do
            %{balance: amount}
          else
            %{balance: balance}
          end
        end)
      #|> Enum.reduce(fn x, acc -> x.balance + acc.balance} end)
      #|> Map.values()
      #|> Enum.sum()
      |> Enum.to_list()

    render(conn, "index.json", events: all_events)
  end 
end
