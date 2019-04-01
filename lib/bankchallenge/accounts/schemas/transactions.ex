defmodule BankChallenge.Accounts.Schemas.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias BankChallenge.Accounts.Schemas, as: S
  
  @primary_key {:transaction_number, :binary_id, autogenerate: false}
  @derive {Phoenix.Param, key: :transaction_number}

  schema "transactions" do
    field :name, :string
    field :amount, :integer
    field :account_number, :binary_id
    field :to_account_number, :binary_id
    has_one :account_number_account, {"accounts", S.Account}, foreign_key: :account_number
    has_one :to_account_number_account, {"accounts", S.Account}, foreign_key: :to_account_number
    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:transaction_number, :name, :account_number, :to_account_number, :amount])
    |> validate_required([:transaction_number, :name, :account_number, :amount])
  end

  @doc false
  def changeset_transfer(transaction, attrs) do
    transaction
    |> cast(attrs, [:transaction_number, :name, :account_number, :to_account_number, :amount])
    |> validate_required([:transaction_number, :name, :account_number, :to_account_number, :amount])
  end
end
