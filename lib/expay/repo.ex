defmodule Expay.Repo do
  use Ecto.Repo,
    otp_app: :expay,
    adapter: Ecto.Adapters.Postgres
end
