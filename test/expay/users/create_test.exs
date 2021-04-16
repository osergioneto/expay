defmodule Expay.UsersTest do
  use Expay.DataCase, async: true

  alias Expay.Users
  alias Expay.Users.Schemas.User

  describe "create_user/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Sérgio Neto",
        email: "sergio@gmail.com",
        email_confirmation: "sergio@gmail.com",
        document_number: "123456789",
        password: "123456",
        password_confirmation: "123456"
      }

      {:ok, %{create_user: created_user}} = Users.create_user(params)
      user = Repo.get(User, created_user.id)

      assert created_user == user
    end

    test "when all params are incorrect, returns an error" do
      params = %{
        name: "Sérgio Neto",
        email: "sergio@gmail.com",
        document_number: "123456789",
        password: "123",
        password_confirmation: "123"
      }

      {:error, errors} = Users.create_user(params)

      expected_response = [
        password_confirmation: {"should be at least %{count} character(s)", [count: 6, validation: :length, kind: :min, type: :string]},
        password: {"should be at least %{count} character(s)", [count: 6, validation: :length, kind: :min, type: :string]},
        email_confirmation: {"can't be blank", [validation: :required]}
      ]

      assert expected_response == errors
    end
  end
end
