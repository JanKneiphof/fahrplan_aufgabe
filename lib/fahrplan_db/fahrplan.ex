defmodule FahrplanDb.Fahrplan do
	
	import Ecto.Query, warn: false

	alias FahrplanDb.Repo
	alias FahrplanDb.Linie
	
	def list_linien do
		Repo.all(Linie)
	end
	
	def get_linie!(id) do
		Repo.get!(Linie, id)
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
end