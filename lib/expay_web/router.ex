defmodule ExpayWeb.Router do
  use ExpayWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExpayWeb do
    pipe_through :api
  end
end