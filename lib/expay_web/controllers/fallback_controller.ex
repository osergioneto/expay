defmodule ExpayWeb.FallbackController do
  use ExpayWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ExpayWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
