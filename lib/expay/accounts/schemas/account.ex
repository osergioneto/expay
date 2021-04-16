defmodule Expay.Accounts.Schemas.Account do
  @moduledoc """
  Account of a user.
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias Expay.Users.Schemas.User

  @required [:balance, :number, :agency, :user_id]
  @optional []
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "accounts" do
    field :balance, :integer
    field :number, :string
    field :agency, :string, default: "1"
    belongs_to :user, User

    timestamps()
  end

  # TODO: Add validation on number and agency
  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required ++ @optional)
    |> validate_required(@required)
    |> unique_constraint(:number)
    |> check_constraint(:balance, name: :balance_must_be_positive)
  end
end
