defmodule Expay.Accounts.Schemas.Account do
  @moduledoc """
  Account of a user.
  """
  use Ecto.Schema
  alias Expay.Users.Schemas.User

  @required [:balance, :number, :agency, :user_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :balance, :integer
    field :number, :string
    field :agency, :string
    belongs_to :user, User

    timestamps()
  end
end
