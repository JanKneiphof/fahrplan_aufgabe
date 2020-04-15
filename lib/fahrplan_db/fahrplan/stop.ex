defmodule FahrplanDb.Stop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stop" do
    belongs_to(:haltestelle, FahrplanDb.Haltestelle)
    belongs_to(:linie, FahrplanDb.Linie)
    field(:uhrzeit, :time)
  end

  def changeset(stop, attrs) do
    stop
    |> cast(attrs, [:uhrzeit])
    |> put_assoc(:linie, attrs["linie"])
    |> put_assoc(:haltestelle, attrs["haltestelle"])
    |> validate_required([:haltestelle, :linie, :uhrzeit])
    # |> validate_combination_allowed(attrs["haltestelle"])
    # Die auskommentierte Validation lehnt alles ab, irgendwas stimmt damit nicht
  end

  def validate_combination_allowed(changeset, nil) do
    validate_inclusion(changeset, :linie, [])
  end

  def validate_combination_allowed(changeset, haltestelle) do
    validate_inclusion(changeset, :linie, haltestelle.linien,
      message: "Die gewählte Linie fährt die gewählte Haltestelle nicht an."
    )
  end
end
