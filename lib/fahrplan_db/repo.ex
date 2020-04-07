defmodule FahrplanDb.Repo do
  use Ecto.Repo,
    otp_app: :fahrplan_db,
    adapter: Ecto.Adapters.Postgres
end
