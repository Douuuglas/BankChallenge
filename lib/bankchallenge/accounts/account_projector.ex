defmodule BankChallenge.Accounts.Projectors.AccountProjector do
  use Ecto.Schema

  @primary_key {:account_number, :binary_id, autogenerate: false}
  @derive {Phoenix.Param, key: :account_number}

  schema "accounts" do
    field :username, :string
    field :email, :string
    field :hashed_password, :string
    field :balance, :decimal

    timestamps()
  end
end