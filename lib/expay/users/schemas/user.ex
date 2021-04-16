defmodule Expay.Users.Schemas.User do
  @moduledoc """
  The user of the application.
  """
  use Ecto.Schema

  import Ecto.Changeset
  import Expay.Changesets

  alias Expay.Users.Schemas.Password
  alias Expay.Accounts.Schemas.Account

  @required [:name, :email, :document_number]
  @optional []
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :name, :string
    field :email, :string
    field :document_number, :string
    has_one :password, Password
    has_one :account, Account

    timestamps()
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_length(:name, min: 2)
    |> validate_email(:email)
    |> unique_constraint(:email)
    |> unique_constraint(:document_number)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
