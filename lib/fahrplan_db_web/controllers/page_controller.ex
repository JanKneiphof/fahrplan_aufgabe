defmodule FahrplanDbWeb.PageController do
  use FahrplanDbWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
