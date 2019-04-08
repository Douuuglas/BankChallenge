defmodule BankChallengeWeb.SessionView do
  use BankChallengeWeb, :view

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end

  def render("invalid_credentials.json", _) do
    %{errors: "invalid credentials"}
  end
end