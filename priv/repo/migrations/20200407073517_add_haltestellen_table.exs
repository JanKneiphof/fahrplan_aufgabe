defmodule FahrplanDb.Repo.Migrations.AddHaltestellenTable do
  use Ecto.Migration
  import Ecto.Migration

  def change do
    create table(:haltestelle) do
      add :name, :string

      timestamps()
    end
  end
end
