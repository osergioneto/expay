defmodule Expay.Users.Schemas.User do
  @moduledoc """
  The user of the application.
  """
  use Ecto.Schema

  @required [:name, :email, :document_number]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :name, :string
    field :email, :string
    field :document_number, :string
    has_one :password, Expay.Users.Schemas.Password

    timestamps()
  end
end
