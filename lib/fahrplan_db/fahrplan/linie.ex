defmodule FahrplanDb.Linie do
  use Ecto.Schema
  import Ecto.Changeset

  schema "linie" do
    field :name, :string
    many_to_many(:haltestellen, FahrplanDb.Haltestelle, join_through: "haltstellen_linien")

    timestamps()
  end

  def changeset(linie, attrs) do
    linie
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
