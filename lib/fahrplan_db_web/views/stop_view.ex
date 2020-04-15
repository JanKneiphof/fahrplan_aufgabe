defmodule FahrplanDbWeb.StopView do
  use FahrplanDbWeb, :view

  def haltestellen_select_options(haltestellen) do
    id_name_tuple_list = Enum.map(haltestellen, fn x -> {x.name, x.id} end)
    [{"Bitte Haltestelle wählen", -1}] ++ id_name_tuple_list
  end

  def linien_select_options(linien) do
    id_name_tuple_list = Enum.map(linien, fn x -> {x.name, x.id} end)
    [{"Bitte Linie wählen", -1}] ++ id_name_tuple_list
  end
end
