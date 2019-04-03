defmodule BankChallengeWeb.SessionView do
  use BankChallengeWeb, :view

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
end