defmodule BankChallange.AccountManager do
  alias BankChallenge.Repo
  alias BankChallenge.Accounts.Schemas, as: S
  alias BankChallenge.AccountManager.Guardian
  alias Bcrypt

  def authenticate_user(username, password) do
    case Repo.get_by(S.Account, username: username) do
      nil ->
        Bcrypt.no_user_verify()
        {:error, :invalid_credentials}
      acc ->
        if Bcrypt.verify_pass(password, acc.hashed_password) do
          Guardian.encode_and_sign(acc)
        else
          {:error, :invalid_credentials}
        end
    end
  end
end