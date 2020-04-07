defmodule FahrplanDb.Haltestelle do
	use Ecto.Schema
	import Ecto.Changeset

	schema "haltestelle" do
		field :name, :string

		timestamps()
	end

	def changeset(linie, attrs) do
		linie
		|> cast(attrs, [:name])
		|> validate_required([:name])
	end
end