defmodule BankChallengeWeb.ReportView do
  use BankChallengeWeb, :view

  require Protocol
  Protocol.derive(Jason.Encoder, EventStore.RecordedEvent, only: [
    :created_at, :data, :event_type])

  def render("index.json", %{account: report}) do
     %{account: report}
  end
end