defmodule FahrplanDb.Linie do
  use Ecto.Schema
  import Ecto.Changeset

  schema "linie" do
    field :name, :string

    many_to_many(:haltestellen, FahrplanDb.Haltestelle,
      join_through: "haltestellen_linien",
      on_delete: :delete_all
    )

    timestamps()
  end

  def changeset(linie, attrs) do
    linie
    |> cast(attrs, [:name])
    |> put_assoc(:haltestellen, attrs["haltestellen"])
    |> validate_required([:name])
  end
end
