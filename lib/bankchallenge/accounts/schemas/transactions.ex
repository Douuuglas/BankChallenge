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
  def add_funds_changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:account_number, :to_account_number, :amount])
    |> validate_required([:account_number, :amount])
    |> validate_number(:amount, greater_than: 0)
    |> put_change(:transaction_number, UUID.uuid4())
    |> put_change(:name, "AddFunds")
  end

  def remove_funds_changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:account_number, :to_account_number, :amount])
    |> validate_required([:account_number, :amount])
    |> validate_number(:amount, less_than: 0)
    |> put_change(:transaction_number, UUID.uuid4())
    |> put_change(:name, "RemoveFunds")
  end

  @doc false
  def transfer_funds_changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:account_number, :to_account_number, :amount])
    |> validate_required([:account_number, :to_account_number, :amount])
    |> validate_number(:amount, less_than: 0)
    |> put_change(:transaction_number, UUID.uuid4())
    |> put_change(:name, "TransferFunds")
  end
end
