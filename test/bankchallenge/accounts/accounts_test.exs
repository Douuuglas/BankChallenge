defmodule BankChallenge.AccountsTest do
  use BankChallenge.DataCase

  alias BankChallenge.Accounts

  describe "accounts" do
    alias BankChallenge.Accounts.Schemas, as: S

    @account_valid_attrs %{
      username: "aline",
      email: "aline.guesser@gmail.com",
      password: "senha"
    }

    @account_invalid_attrs %{
      username: nil,
      email: nil,
      password: nil
    }

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@account_valid_attrs)
        |> Accounts.create_account()

      account
    end

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounts.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounts.get_account!(account.account_number) == account
    end

    test "create_account/1 with valid data creates a account" do
      assert {:ok, %S.Account{} = account} = Accounts.create_account(@account_valid_attrs)
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_account(@account_invalid_attrs)
    end

    # test "transfer_funds/1 returns an account with less funds" do
    #   account = account_fixture()
    #   transfer_funds = %{
    #     account_number: account.account_number,
    #     to_account_number: 
    #     amount
    #   }

    #   assert %Ecto.Changeset{} = Accounts.change_account(account)
    # end

    test "remove_funds/1 return an account with less funds" do
      account = account_fixture()
      balanceBefore =  account.balance
      remove_funds = %{
        account_number: account.account_number,
        amount: 10}

      assert {:ok, acc} = Accounts.remove_funds(remove_funds)
      assert acc.balance == balanceBefore - remove_funds.amount
    end

    test "add_funds/1 return an account wirh more funds" do
      account = account_fixture()
      balanceBefore =  account.balance
      add_funds = %{
        account_number: account.account_number,
        amount: 10}

      assert {:ok, acc} = Accounts.add_funds(add_funds)
      assert acc.balance == balanceBefore + add_funds.amount
    end
  end
end
