defmodule FahrplanDb.Haltestelle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "haltestelle" do
    field :name, :string
    many_to_many(:linien, FahrplanDb.Linie, join_through: "haltestellen_linien")
    timestamps()
  end

  def changeset(linie, attrs) do
    linie
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
