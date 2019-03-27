defmodule BankChallenge.Accounts.Schemas.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias BankChallenge.Accounts.Schemas, as: S

  @primary_key {:account_number, :binary_id, autogenerate: false}
  @derive {Phoenix.Param, key: :account_number}

  schema "accounts" do
    field :username, :string
    field :email, :string
    field :hashed_password, :string
    field :balance, :decimal
    has_many :account_number_transaction, S.Transaction, foreign_key: :account_number
    has_many :from_account_number_transaction, S.Transaction, foreign_key: :from_account_number

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    attrs = Map.merge(attrs, %{"account_number" => UUID.uuid4(), "balance" => 1000})

    account
    |> cast(attrs, [:account_number, :username, :email, :hashed_password, :balance])
    |> validate_required([:account_number, :username, :email, :hashed_password, :balance])
  end
end
