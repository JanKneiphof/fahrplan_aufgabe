defmodule FahrplanDb.StopTest do
  use FahrplanDb.DataCase

  alias FahrplanDb.Haltestelle
  alias FahrplanDb.Fahrplan
  alias FahrplanDb.Linie
  alias FahrplanDb.Stop
  alias FahrplanDb.Repo

  describe "stop" do
    @invalid_attrs %{
      "uhrzeit" => ~T[12:34:56.7890],
      "haltestelle" => %Haltestelle{name: "invalid", linien: []},
      "linie" => %Linie{name: "invalid", haltestellen: []}
    }

    test "create_stop/1 with valid data" do
      haltestelle = Repo.insert!(%Haltestelle{name: "Leverkusen Mitte"})
      linie = Repo.insert!(%Linie{name: "Leverkusen Rheindorf", haltestellen: [haltestelle]})

      valid_attrs = %{
        "haltestelle" => haltestelle |> Repo.preload(:linien),
        "linie" => linie |> Repo.preload(:haltestellen),
        "uhrzeit" => ~T[12:34:56.7890]
      }

      assert {:ok, %Stop{} = stop} = Fahrplan.create_stop(valid_attrs)
      assert stop.uhrzeit == ~T[12:34:56]
    end

    test "create_stop/1 with invalid data" do
      assert {:error, %Ecto.Changeset{}} = Fahrplan.create_stop(@invalid_attrs)
    end

    test "create_stop/1 with invalid Linien/Haltestellen combination" do
      haltestelle = Repo.insert!(%Haltestelle{name: "Leverkusen Mitte"})
      linie = Repo.insert!(%Linie{name: "Leverkusen Rheindorf"})

      invalid_attrs = %{
        "haltestelle" => haltestelle |> Repo.preload(:linien),
        "linie" => linie |> Repo.preload(:haltestellen),
        "uhrzeit" => ~T[12:34:56.7890]
      }

      assert {:error, %Ecto.Changeset{}} = Fahrplan.create_stop(invalid_attrs)
    end
  end
end
