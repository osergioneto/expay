defmodule ExpayWeb.UserControllerTest do
  use ExpayWeb.ConnCase, async: true

  describe "POST /api/users" do
    setup do
      params = %{
        name: "Gaia",
        email: "gaia@email.com",
        email_confirmation: "gaia@email.com",
        document_number: "123456789",
        password: "123456",
        password_confirmation: "123456"
      }

      {:ok, user: params}
    end

    test "succefully create user when all params are valid", %{conn: conn, user: user} do
      response =
        conn
          |> post("/api/users", user)
          |> json_response(:created)

      assert response == %{
        "message" => "User created",
        "user" => %{
          "account" => %{
            "number" => response["user"]["account"]["number"],
            "agency" => "1",
            "balance" => 100000
          },
          "email" => "gaia@email.com",
          "name" => "Gaia",
          "id" => response["user"]["id"]
        }
      }
    end

    test "fail with 400 when email_confirmation does NOT match email", %{conn: conn, user: user} do
      user = %{user | email_confirmation: "diana@email.com"}
      response =
        conn
          |> post("/api/users", user)
          |> json_response(:bad_request)

      assert response == %{"errors" => %{"detail" => "Bad Request"}}
    end

    test "fail with 400 when password_confirmation does NOT match password", %{conn: conn, user: user} do
      user = %{user | password_confirmation: nil}
      IO.inspect(user, label: "user")
      response =
        conn
          |> post("/api/users", user)
          |> json_response(:bad_request)
          |> IO.inspect()

      assert response == %{"errors" => %{"detail" => "Bad Request"}}
    end
  end
end
