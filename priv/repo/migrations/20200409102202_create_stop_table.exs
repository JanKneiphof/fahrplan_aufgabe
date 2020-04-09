defmodule FahrplanDb.Repo.Migrations.CreateStopTable do
  use Ecto.Migration
  import Ecto.Migration

  def change do
    create table("stop") do
      add :haltestelle_id, references(:haltestelle)
      add :linie_id, references(:linie)
    end
   end
end
