defmodule BankChallenge.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :transaction_number, :uuid, primary_key: true
      add :name, :string
      add :account_number, references(:accounts, column: :account_number, type: :uuid)
      add :to_account_number, references(:accounts, column: :account_number, type: :uuid), null: true
      add :amount, :integer
      
      timestamps()
    end
  end
end
