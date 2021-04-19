defmodule ExpayWeb.Router do
  use ExpayWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExpayWeb do
    pipe_through :api

    post "/users", UserController, :create

    post "/accounts/:number/deposit/:value", AccountController, :deposit
    post "/accounts/:number/withdraw/:value", AccountController, :withdraw
    post "/accounts/transfer", AccountController, :transfer
    get "/accounts/balance/:id", AccountController, :balance
  end
end
