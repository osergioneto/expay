defmodule Expay.Users do
  @moduledoc """
  Domain public functions about the users context.
  """

  alias Ecto.Multi
  alias Expay.Repo
  alias Expay.Users.Inputs.CreateUser
  alias Expay.Users.Schemas.User
  alias Expay.Accounts.Schemas.Account

  @doc """
  Given a VALID changeset it attempts to create a new user.
  """
  def create_user(params) do
    Multi.new()
    |> Multi.run(:validate_user, fn _, _changes -> changeset_create_input(params) end)
    |> Multi.run(:create_user, fn repo, _changes -> insert_user(repo, params) end)
    |> Multi.run(:create_account, fn repo, %{create_user: user} -> insert_account(repo, user) end)
    |> Multi.run(:preload_data, fn repo, %{create_user: user} -> preload_data(repo, user) end)
    |> run_transaction()
  end

  defp changeset_create_input(params) do
    case CreateUser.changeset(params) do
      %{valid?: true, changes: changes} -> {:ok, changes}
      %{valid?: false, errors: errors} -> {:error, errors}
    end
  end

  defp insert_user(repo, user) do
    user
    |> User.changeset()
    |> repo.insert()
  end

  defp insert_account(repo, user) do
    user.id
    |> account_changeset()
    |> repo.insert()
  end

  defp account_changeset(user_id) do
    params = %{user_id: user_id, balance: 100000, number: Ecto.UUID.generate, agency: "1"}

    Account.changeset(params)
  end

  defp preload_data(repo, user) do
    {:ok, repo.preload(user, :account)}
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, changes} -> {:ok, changes}
    end
  end
end
