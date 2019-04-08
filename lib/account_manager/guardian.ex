defmodule BankChallenge.AccountManager.Guardian do
  use Guardian, otp_app: :bankchallenge

  alias BankChallenge.Accounts

  #account.account_number
  def subject_for_token(account, _claims) do
    {:ok, to_string(account.account_number)}
  end

  def resource_from_claims(%{"sub" => account_number}) do
    case Accounts.get_account(account_number) do
      nil -> {:error, :account_not_found}
      acc -> {:ok, acc}
    end
  end
end