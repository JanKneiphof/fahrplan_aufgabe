defmodule FahrplanDb.Repo.Migrations.AddLinienTable do
  use Ecto.Migration

  def change do
    create table("linie") do
      add :name, :string

      timestamps()
    end
  end
end
