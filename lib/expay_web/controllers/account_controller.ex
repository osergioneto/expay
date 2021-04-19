defmodule ExpayWeb.AccountController do
  @moduledoc """
  Actions related to the account resource.
  """
  use ExpayWeb, :controller
  alias Expay.Accounts

  action_fallback(ExpayWeb.FallbackController)

  def deposit(conn, params) do
    IO.inspect(params, label: "params")
    with {:ok, %{account: account}} <- Accounts.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("deposit.json", account: account)
    end
  end

  def withdraw(conn, params) do
    IO.inspect(params, label: "params")
    with {:ok, %{account: account}} <- Accounts.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("withdraw.json", account: account)
    end
  end
end