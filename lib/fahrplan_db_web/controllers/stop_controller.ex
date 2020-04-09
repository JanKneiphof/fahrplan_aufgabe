defmodule FahrplanDbWeb.StopController do
  use FahrplanDbWeb, :controller

  alias FahrplanDb.Fahrplan
  def show(conn, %{"id" => id}) do
    stop = Fahrplan.get_stop!(id)
    render(conn, "show.html", stop: stop)
  end
end
