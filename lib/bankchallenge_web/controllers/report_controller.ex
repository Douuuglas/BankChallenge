defmodule BankChallengeWeb.ReportController do
  use BankChallengeWeb, :controller

  action_fallback BankChallengeWeb.FallbackController

  def index(conn, _params) do
    all_transactions =
      EventStore.stream_all_forward()
      |> Stream.filter(fn ev -> ev.data.account_number == conn.assigns.current_account.account_number end)
      |> Stream.map(fn ev ->
        amount = Map.get(ev.data, :amount, Map.get(ev.data, :balance))

        %{data: NaiveDateTime.to_date(ev.created_at),
        amount: amount,
        type: String.replace(ev.event_type, "Elixir.BankChallenge.Accounts.Events.", "")}
      end)
      |> Enum.to_list()
      |> Enum.group_by(fn x -> x.data end,
        fn ev -> 
          %{amount: ev.amount,
            type: ev.type}
        end)
      
      report =
      %{
        balance: 0,
        history: all_transactions
      }

    render(conn, "index.json", account: report)
  end 
end
