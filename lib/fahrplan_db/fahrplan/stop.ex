defmodule FahrplanDb.Stop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stop" do
    belongs_to(:haltestelle, FahrplanDb.Haltestelle, on_replace: :update)
    belongs_to(:linie, FahrplanDb.Linie, on_replace: :update)
    field(:uhrzeit, :time)
  end

  def changeset(stop, attrs) do
    stop
    |> cast(attrs, [:uhrzeit])
    |> put_change_id(:linie_id, attrs["linie"])
    |> put_change_id(:haltestelle_id, attrs["haltestelle"])
    |> validate_combination_allowed(attrs["haltestelle"], attrs["linie"])
    |> validate_required([:haltestelle, :linie, :uhrzeit])

  end

  def validate_combination_allowed(changeset, nil, nil) do
    validate_inclusion(changeset, :linie_id, [])
  end

  def validate_combination_allowed(changeset, haltestelle, linie) do
    validate_inclusion(changeset, :linie_id, Enum.map(haltestelle.linien, fn x -> x.id end),
      message: "Die gewählte Linie fährt die gewählte Haltestelle nicht an."
    )
    validate_inclusion(changeset, :haltestelle_id, Enum.map(linie.haltestellen, fn x -> x.id end),
      message: "Die gewählte Haltestelle wird von der gewählten Linie nicht angefahren."
    )
  end

  def put_change_id(changeset, key, nil) do
    put_change(changeset, key, nil)
  end

  def put_change_id(changeset, key, value) do
    put_change(changeset, key, value.id)
  end
end
