defmodule FahrplanDb.Repo.Migrations.UpdateDeleteBehaviorOnStop do
  use Ecto.Migration

  def change do
    alter table("stop") do
      modify(:haltestelle_id, references(:haltestelle, on_delete: :delete_all))
      modify(:linie_id, references(:linie, on_delete: :delete_all))
    end
  end
end
