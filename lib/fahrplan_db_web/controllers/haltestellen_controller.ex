defmodule FahrplanDbWeb.HaltestellenController do
  use FahrplanDbWeb, :controller

  alias FahrplanDb.Fahrplan
  alias FahrplanDb.Haltestelle

  def index(conn, _params) do
    haltestellen = Fahrplan.list_haltestellen()
    render(conn, "index.html", haltestellen: haltestellen)
  end

  def new(conn, _params) do
    changeset = Fahrplan.change_haltestelle(%Haltestelle{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"haltestelle" => haltestellen_params}) do
    case Fahrplan.create_haltestelle(haltestellen_params) do
      {:ok, _haltestelle} ->
        conn
        |> put_flash(:info, "Haltestelle created successfully.")
        |> redirect(to: Routes.haltestellen_path(conn, :index, Fahrplan.list_linien()))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    haltestelle = Fahrplan.get_haltestelle_preload_linien(id)
    render(conn, "show.html", haltestelle: haltestelle)
  end

  def edit(conn, %{"id" => id}) do
    haltestelle = Fahrplan.get_haltestelle_preload_linien(id)
    changeset = Fahrplan.change_haltestelle(haltestelle)
    render(conn, "edit.html", haltestelle: haltestelle, changeset: changeset)
  end

  def update(conn, %{"id" => id, "haltestelle" => haltestellen_params}) do
    haltestelle = Fahrplan.get_haltestelle_preload_linien(id)

    case Fahrplan.update_haltestelle(haltestelle, haltestellen_params) do
      {:ok, haltestelle} ->
        conn
        |> put_flash(:info, "Haltestelle updated successfully.")
        |> redirect(to: Routes.haltestellen_path(conn, :show, haltestelle))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", haltestelle: haltestelle, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    haltestelle = Fahrplan.get_haltestelle(id)
    {:ok, _haltestelle} = Fahrplan.delete_haltestelle(haltestelle)

    conn
    |> put_flash(:info, "Haltestelle deleted.")
    |> redirect(to: Routes.haltestellen_path(conn, :index))
  end
end
