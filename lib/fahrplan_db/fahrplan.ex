defmodule FahrplanDb.Fahrplan do

	import Ecto.Query, warn: false

	alias FahrplanDb.Repo
	alias FahrplanDb.Linie
	alias FahrplanDb.Haltestelle
	alias FahrplanDb.Stop

	def list_linien do
		Repo.all(Linie)
	end

	def get_linie!(id) do
		Repo.get!(Linie, id)
		|> Repo.preload(:haltestellen)
	end

	def create_linie(attrs \\ %{}) do
		%Linie{}
		|> Linie.changeset(attrs)
		|> Repo.insert()
	end

	def update_linie(%Linie{} = linie, attrs) do
		linie
		|> Linie.changeset(attrs)
		|> Repo.update()
	end

	def delete_linie(%Linie{} = linie) do
		Repo.delete(linie)
	end

	def change_linie(%Linie{} = linie) do
		Linie.changeset(linie, %{})
	end

	def list_haltestellen do
		Repo.all(Haltestelle)
	end

	def change_haltestelle(%Haltestelle{} = haltestelle) do
		Haltestelle.changeset(haltestelle, %{})
	end

	def create_haltestelle(params) do
		%Haltestelle{}
		|>Haltestelle.changeset(params)
		|>Repo.insert()
	end

	def get_haltestelle!(id) do
		Repo.get!(Haltestelle, id)
		|> Repo.preload(:linien)
	end

	def get_haltestellen!(id_list) do
		Enum.map(id_list, &get_haltestelle!/1)
	end

	def update_haltestelle(%Haltestelle{} = haltestelle, attrs) do
		haltestelle
		|> Haltestelle.changeset(attrs)
		|> Repo.update()
	end

	def list_stops() do
		Repo.all(Stop)
		|> Repo.preload([:haltestelle, :linie])
	end

	def get_stop!(id) do
		Repo.get!(Stop, id)
		|> Repo.preload([:haltestelle, :linie])
	end

	def change_stop(%Stop{} = stop) do
		Stop.changeset(stop, %{})
	end

	def create_stop(params) do
		%Stop{}
		|> Stop.changeset(params)
		|> Repo.insert()
	end

	def delete_haltestelle(haltestelle) do
		Repo.delete(haltestelle)
	end
end
