defmodule BankChallenge.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :account_number, :uuid, primary_key: true
      add :username, :string
      add :email, :string
      add :hashed_password, :string
      add :balance, :decimal
      
      timestamps()
    end
  end
end
