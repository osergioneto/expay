defmodule ExpayWeb.UserView do
  # alias Expay.Users.Schemas.User
  alias Expay.Accounts.Schemas.Account

  def render("create.json", %{
    user: %{
      account: %Account{number: number, agency: agency, balance: balance},
      id: user_id,
      name: name,
      email: email
      }
    }) do
    %{
      message: "User created",
      user: %{
        id: user_id,
        name: name,
        email: email,
        account: %{
          number: number,
          agency: agency,
          balance: balance
        }
      }
    }
  end
end
