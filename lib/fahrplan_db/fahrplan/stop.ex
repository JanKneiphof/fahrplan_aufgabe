defmodule FahrplanDb.Stop do
  use Ecto.Schema
  import Ecto.Schema

  schema "stop" do
    belongs_to(:haltestelle, FahrplanDb.Haltestelle)
    belongs_to(:linie, FahrplanDb.Linie)
    field(:uhrzeit, :time)
  end

end
