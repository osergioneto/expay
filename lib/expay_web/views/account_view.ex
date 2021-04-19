defmodule ExpayWeb.AccountView do
  alias Expay.Accounts.Schemas.Account

  def render("deposit.json", %{
    account: %{
      balance: balance,
      agency: agency,
      number: number
      }
    }) do
    %{
      message: "Successful deposit",
      account: %{
        balance: balance,
        agency: agency,
        number: number
      }
    }
  end

  def render("withdraw.json", %{
    account: %{
      balance: balance,
      agency: agency,
      number: number
      }
    }) do
    %{
      message: "Successful withdraw",
      account: %{
        balance: balance,
        agency: agency,
        number: number
      }
    }
  end

  def render("transfer.json", %{
    transfer: %{"from" => from, "to" => to, "value" => value}}) do
    %{
      message: "Successful transfer",
      transfer: %{
        from: from,
        to: to,
        value: value
      }
    }
  end
end
