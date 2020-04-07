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
end
