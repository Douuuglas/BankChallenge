defmodule BankChallange.AccountManager do
  alias Comeonin.Bcrypt
  alias BankChallenge.Repo
  alias BankChallenge.Accounts.Schemas, as: S
  alias BankChallenge.AccountManager.Guardian

  def authenticate_user(username, password) do
    case Repo.get_by(S.Account, username: username) do
      nil ->
        Bcrypt.dummy_checkpw()
        {:error, :invalid_credentials}
      acc ->
        if Bcrypt.checkpw(password, acc.hashed_password) do
          Guardian.encode_and_sign(acc)
        else
          {:error, :invalid_credentials}
        end
    end
  end
end