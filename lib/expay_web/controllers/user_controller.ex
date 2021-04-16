defmodule ExpayWeb.UserController do
  @moduledoc """
  Actions related to the user resource.
  """
  use ExpayWeb, :controller
  alias Expay.Users
  # alias Expay.Users.Schemas.User

  action_fallback(ExpayWeb.FallbackController)

  def create(conn, params) do
    with {:ok, %{preload_data: user}} <- Users.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
