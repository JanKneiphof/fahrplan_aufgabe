defmodule FahrplanDbWeb.LinieView do
  use FahrplanDbWeb, :view

  def haltestellen_name_id(haltestellen) do
    Enum.map(haltestellen, fn x -> {x.name, x.id} end)
  end

  def linie_has_haltestelle?(linie, haltestelle)do
    case Enumerable.impl_for(linie.haltestellen) do
      nil -> false
      _ ->
        Enum.map(linie.haltestellen, fn x -> x.id end)
        |>Enum.member?(haltestelle.id)

    end
  end
end
