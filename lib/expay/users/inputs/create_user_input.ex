defmodule Expay.Users.Inputs.CreateUser do
  @moduledoc """
  Input data for calling create_user/1.
  """
  use Ecto.Schema

  import Ecto.Changeset
  import Expay.Changesets

  @required [:name, :email, :email_confirmation, :document_number, :password, :password_confirmation]
  @optional []

  @primary_key false
  embedded_schema do
    field :name, :string
    field :email, :string
    field :email_confirmation, :string
    field :password, :string
    field :password_confirmation, :string
    field :document_number, :string
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required ++ @optional)
    |> validate_required(@required)
    |> validate_length(:name, min: 2)
    |> validate_length(:password, min: 6)
    |> validate_length(:password_confirmation, min: 6)
    |> validate_email(:email)
    |> validate_email(:email_confirmation)
    |> validate_fields([:email, :email_confirmation], fn changes, changeset ->
      if changes[:email] == changes[:email_confirmation] do
        changeset
      else
        add_error(changeset, :email_and_confirmation, "Email and confirmation must be the same")
      end
    end)
    |> validate_fields([:password, :password_confirmation], fn changes, changeset ->
      if changes[:email] == changes[:email_confirmation] do
        changeset
      else
        add_error(changeset, :password_and_confirmation, "Password and confirmation must be the same")
      end
    end)
  end
end
