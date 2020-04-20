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
    haltestellen = Fahrplan.list_haltestellen()
    render(conn, "new.html", changeset: changeset, haltestellen: haltestellen)
  end

  def create(conn, %{"linie" => linie_params}) do
    updated_params = create_params_with_haltestellen(linie_params)

    case Fahrplan.create_linie(updated_params) do
      {:ok, linie} ->
        conn
        |> put_flash(:info, "Linie created successfully.")
        |> redirect(to: Routes.linie_path(conn, :show, linie))

      {:error, %Ecto.Changeset{} = changeset} ->
        haltestellen = Fahrplan.list_haltestellen()

        render(conn, "new.html", changeset: changeset, linie: %Linie{}, haltestellen: haltestellen)
    end
  end

  def show(conn, %{"id" => id}) do
    linie = Fahrplan.get_linie_preload_haltestellen!(id)
    render(conn, "show.html", linie: linie)
  end

  def edit(conn, %{"id" => id}) do
    linie = Fahrplan.get_linie_preload_haltestellen!(id)
    changeset = Fahrplan.change_linie(linie)
    haltestellen = Fahrplan.list_haltestellen()

    render(conn, "edit.html",
      linie: linie,
      changeset: changeset,
      haltestellen: haltestellen
    )
  end

  def update(conn, %{"id" => id, "linie" => linie_params}) do
    linie = Fahrplan.get_linie_preload_haltestellen!(id)

    update_params = create_params_with_haltestellen(linie_params)

    case Fahrplan.update_linie(linie, update_params) do
      {:ok, linie} ->
        conn
        |> put_flash(:info, "Linie updated successfully.")
        |> redirect(to: Routes.linie_path(conn, :show, linie))

      {:error, %Ecto.Changeset{} = changeset} ->
        haltestellen = Fahrplan.list_haltestellen()
        render(conn, "edit.html", linie: linie, changeset: changeset, haltestellen: haltestellen)
    end
  end

  def delete(conn, %{"id" => id}) do
    linie = Fahrplan.get_linie(id)
    {:ok, _linie} = Fahrplan.delete_linie(linie)

    conn
    |> put_flash(:info, "Linie deleted successfully.")
    |> redirect(to: Routes.linie_path(conn, :index))
  end

  defp create_params_with_haltestellen(%{"haltestellen" => haltestellen} = linie_params) do
    selected_haltestellen = Enum.map(haltestellen, &Fahrplan.get_haltestelle(&1))

    %{linie_params | "haltestellen" => selected_haltestellen}
  end

  defp create_params_with_haltestellen(linie_params) do
    Map.merge(linie_params, %{"haltestellen" => []})
  end
end
