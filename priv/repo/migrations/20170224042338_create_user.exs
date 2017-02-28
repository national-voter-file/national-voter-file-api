defmodule NationalVoterFile.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :encrypted_password, :string

      timestamps()
    end

    create index(:users, [:email], unique: true)
  end
end
