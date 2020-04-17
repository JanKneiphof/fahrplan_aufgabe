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

  def render("edit.html", assigns) do
    selected_values = %{
      haltestelle_id: assigns.stop.haltestelle.id,
      linie_id: assigns.stop.linie.id
    }

    render_template("edit.html", Map.merge(assigns, selected_values))
  end
  def render("new.html", assigns) do
    selected_values = %{
      haltestelle_id: -1,
      linie_id: -1
    }

    render_template("new.html", Map.merge(assigns, selected_values))
  end
end
