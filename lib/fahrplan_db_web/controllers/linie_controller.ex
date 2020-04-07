defmodule FahrplanDbWeb.LinieController do
  use FahrplanDbWeb, :controller

  alias FahrplanDb.Fahrplan
  alias FahrplanDb.Linie

  def index(conn, _params) do
    linien = Fahrplan.list_linien()
    render(conn, "index.html", linien: linien)
  end

  def new(conn, _params) do
    changeset = Fahrplan.change_linie(%Linie{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"linie" => linie_params}) do
    case Fahrplan.create_linie(linie_params) do
      {:ok, linie} ->
        conn
        |> put_flash(:info, "Linie created successfully.")
        |> redirect(to: Routes.linie_path(conn, :show, linie))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    linie = Fahrplan.get_linie!(id)
    render(conn, "show.html", linie: linie)
  end

  def edit(conn, %{"id" => id}) do
    linie = Fahrplan.get_linie!(id)
    changeset = Fahrplan.change_linie(linie)
    render(conn, "edit.html", linie: linie, changeset: changeset)
  end

  def update(conn, %{"id" => id, "linie" => linie_params}) do
    linie = Fahrplan.get_linie!(id)

    case Fahrplan.update_linie(linie, linie_params) do
      {:ok, linie} ->
        conn
        |> put_flash(:info, "Linie updated successfully.")
        |> redirect(to: Routes.linie_path(conn, :show, linie))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", linie: linie, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    linie = Fahrplan.get_linie!(id)
    {:ok, _linie} = Fahrplan.delete_linie(linie)

    conn
    |> put_flash(:info, "Linie deleted successfully.")
    |> redirect(to: Routes.linie_path(conn, :index))
  end
end
