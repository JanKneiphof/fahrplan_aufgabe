defmodule FahrplanDb.Repo.Migrations.CreateLinienHaltestellenRelation do
  use Ecto.Migration

  def change do
    create table(:haltestellen_linien, primary_key: false) do
      add :haltestelle_id, references(:haltestelle)
      add :linie_id, references(:linie)
    end
  end
end
