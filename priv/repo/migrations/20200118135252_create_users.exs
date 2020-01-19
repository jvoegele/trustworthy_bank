defmodule Trustworthy.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do

    create table(:customers_users, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :username, :string
      add :hashed_password, :string

      timestamps()
    end

    create unique_index(:customers_users, [:username])
  end
end
