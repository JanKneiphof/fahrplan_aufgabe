defmodule FahrplanDbWeb.Router do
  use FahrplanDbWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FahrplanDbWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/linien", LinieController
    resources "/haltestellen", HaltestellenController
    resources "/stop", StopController
  end

  scope "/stop", FahrplanDbWeb do
    pipe_through(:browser)

    get("/linie/:id", StopController, :stops_from_linie)
    get("/haltestelle/:id", StopController, :stops_from_haltestelle)
  end

  # Other scopes may use custom stacks.
  # scope "/api", FahrplanDbWeb do
  #   pipe_through :api
  # end
end
