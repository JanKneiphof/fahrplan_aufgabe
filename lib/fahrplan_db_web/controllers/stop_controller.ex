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
    render(conn, "new.html", changeset: changeset, haltestellen: haltestellen, linien: linien)
  end
end
