defmodule Expay.Repo.Migrations.CreateUsersAndPasswordsAndAccounts do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :email, :string
      add :document_number, :string
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:document_number])

    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :balance, :bigint
      add :number, :string
      add :agency, :string
      add :user_id, references(:users, type: :uuid)

      timestamps()
    end

    create unique_index(:accounts, [:user_id])
    create unique_index(:accounts, [:number])
    create constraint(:accounts, :balance_must_be_positive, check: "balance >= 0")
  end
end
