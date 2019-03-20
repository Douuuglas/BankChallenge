defmodule BankChallenge.Repo do
  use Ecto.Repo,
    otp_app: :bankchallenge,
    adapter: Ecto.Adapters.Postgres
end
