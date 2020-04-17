defmodule FahrplanDbWeb.StopController do
  use FahrplanDbWeb, :controller

  alias FahrplanDb.Fahrplan
  alias FahrplanDb.Stop

  def show(conn, %{"id" => id}) do
    stop = Fahrplan.get_stop!(id)
    render(conn, "show.html", stop: stop)
  end

  def new(conn, _params) do
    changeset = Fahrplan.change_stop(%Stop{})
    haltestellen = Fahrplan.list_haltestellen()
    linien = Fahrplan.list_linien()

    render(conn, "new.html",
      changeset: changeset,
      haltestellen: haltestellen,
      linien: linien
    )
  end

  def create(conn, %{"stop" => stop_params}) do
    updated_params = create_params_with_structs(stop_params)

    case Fahrplan.create_stop(updated_params) do
      {:ok, _stop} ->
        conn
        |> put_flash(:info, "stop created successfully.")
        |> redirect(to: Routes.stop_path(conn, :index, Fahrplan.list_stops()))

      {:error, %Ecto.Changeset{} = changeset} ->
        haltestellen = Fahrplan.list_haltestellen()
        linien = Fahrplan.list_linien()
        render(conn, "new.html", changeset: changeset, haltestellen: haltestellen, linien: linien)
    end
  end

  defp create_params_with_structs(
         %{"haltestelle_id" => haltestelle_id, "linie_id" => linie_id} = stop_params
       ) do
    structs = %{
      "haltestelle" => Fahrplan.get_haltestelle_preload_linien(haltestelle_id),
      "linie" => Fahrplan.get_linie_preload_haltestellen(linie_id)
    }

    stop_params
    |> Map.delete("haltestelle_id")
    |> Map.delete("linie_id")
    |> Map.merge(structs)
  end

  def index(conn, _params) do
    stops = Fahrplan.list_stops()
    render(conn, "index.html", stops: stops)
  end

  def delete(conn, %{"id" => id}) do
    stop = Fahrplan.get_stop!(id)
    {:ok, _stop} = Fahrplan.delete_stop(stop)

    conn
    |> put_flash(:info, "Stop deleted successfully")
    |> redirect(to: Routes.stop_path(conn, :index))
  end

  def edit(conn, %{"id" => id}) do
    stop = Fahrplan.get_stop_preload_haltestelle_linie!(id)
    changeset = Fahrplan.change_stop(stop)
    haltestellen = Fahrplan.list_haltestellen()
    linien = Fahrplan.list_linien()

    render(conn, "edit.html",
      stop: stop,
      changeset: changeset,
      haltestellen: haltestellen,
      linien: linien
    )
  end

  def update(conn, %{"id" => id, "stop" => stop_params}) do
    stop = Fahrplan.get_stop_preload_haltestelle_linie!(id)

    case Fahrplan.update_stop(stop, create_params_with_structs(stop_params)) do
      {:ok, stop} ->
        conn
        |> put_flash(:info, "Stop updated succesfully")
        |> redirect(to: Routes.stop_path(conn, :show, stop))

      {:error, %Ecto.Changeset{} = changeset} ->
        haltestellen = Fahrplan.list_haltestellen()
        linien = Fahrplan.list_linien()

        render(conn, "edit.html",
          stop: stop,
          changeset: changeset,
          haltestellen: haltestellen,
          linien: linien
        )
    end
  end

  def stops_from_linie(conn, %{"id" => id}) do
    stops = Fahrplan.list_stops_for_linie(id)
    linie = Fahrplan.get_linie(id)
    render(conn, "linien_stops.html", stops: stops, linie: linie)
  end

  def stops_from_haltestelle(conn, %{"id" => id}) do
    stops = Fahrplan.list_stops_for_haltestelle(id)
    haltestelle = Fahrplan.get_haltestelle(id)
    render(conn, "haltestellen_stops.html", stops: stops, haltestelle: haltestelle)
  end
end
