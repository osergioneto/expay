defmodule Expay.Users.Schemas.Password do
  @moduledoc """
  Password of a user,
  """
  use Ecto.Schema
  alias Expay.Users.Schemas.User

  @required [:password_hash, :algorithm, :user_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "passwords" do
    field :password_hash, :string
    field :algorithm, :string
    belongs_to :user, User

    timestamps()
  end
end
