defmodule Expay.Accounts do
  alias Ecto.Multi
  alias Expay.Repo
  alias Expay.Accounts.Schemas.Account

  def deposit(%{"number" => number, "value" => value} = params) do
    Multi.new()
    |> Multi.run(:account, fn repo, _changes -> get_account(repo, number) end)
    |> Multi.run(:deposit, fn repo, changes ->
      account = Map.get(changes, :account)

      update_balance(repo, account, value, :deposit)
    end)
    |> run_transaction()
  end
  def deposit(_params), do: {:error, "Invalid params. Account number should be binary. Value should be >= 0."}

  def withdraw(%{"number" => number, "value" => value} = params) do
    Multi.new()
    |> Multi.run(:account, fn repo, _changes -> get_account(repo, number) end)
    |> Multi.run(:deposit, fn repo, changes ->
      account = Map.get(changes, :account)

      update_balance(repo, account, value, :withdraw)
    end)
    |> run_transaction()
  end
  def withdraw(_params), do: {:error, "Invalid params. Account number should be binary. Value should be >= 0."}

  def transfer(%{"to" => to, "from" => from, "value" => value}) do
    Multi.new()
    |> Multi.run(:withdraw, fn repo, changes -> withdraw(%{number: from, value: value}) end)
    |> Multi.run(:deposit, fn repo, changes -> deposit(%{number: to, value: value}) end)
    |> run_transaction()
  end

  defp get_account(repo, number) do
    case repo.get_by(Account, number: number) do
      nil -> {:error, "Account not found"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, %Account{balance: balance} = account, value, operation) do
    account
    |> operation(value, operation)
    |> update_account(repo, account)
  end

  defp operation(%Account{balance: balance}, value, operation) do
    value
    |> String.to_integer()
    |> handle_operation(balance, operation)
  end

  defp handle_operation(value, balance, :deposit), do: (balance + value)
  defp handle_operation(value, balance, :withdraw) when balance >= value, do: (balance - value)
  defp handle_operation(value, balance, :withdraw) when balance < value, do: {:error, "Can't withdraw more than balance"}
  defp handle_operation(:error, _balance, _operation), do: {:error, "Invalid deposit value"}

  defp update_account(value, repo, account) do
    params = %{balance: value}

    account
    |> Account.changeset(params)
    |> repo.update()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, changes} -> {:ok, changes}
    end
  end
end
