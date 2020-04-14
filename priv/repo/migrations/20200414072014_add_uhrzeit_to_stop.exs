defmodule FahrplanDb.Repo.Migrations.AddUhrzeitToStop do
  use Ecto.Migration

  def change do
    alter table("stop") do
      add :uhrzeit, :time
    end

  end
end
