defmodule FahrplanDb.Repo.Migrations.UpdateDeleteBehaviorOnStop do
  use Ecto.Migration

  def change do
    alter table("stop") do
      remove(:haltestelle_id)
      remove(:linie_id)
      add(:haltestelle_id, references(:haltestelle, on_delete: :delete_all))
      add(:linie_id, references(:linie, on_delete: :delete_all))
    end
  end
end
