defmodule FahrplanDb.LinieTest do
  use FahrplanDb.DataCase

  alias FahrplanDb.Haltestelle
  alias FahrplanDb.Fahrplan
  alias FahrplanDb.Linie
  alias FahrplanDb.Repo

  describe "linie" do
    @valid_attrs %{
      "name" => "S6"
    }
    @invalid_attrs %{"name" => "", "haltestellen" => [%Haltestelle{name: "invalid"}]}

    test "create_linie/1 with valid data" do
      haltestelle1 = Repo.insert!(%Haltestelle{name: "Leverkusen Mitte"})
      haltestelle2 = Repo.insert!(%Haltestelle{name: "Leverkusen Rheindorf"})

      valid_attrs_haltestellen =
        Map.merge(@valid_attrs, %{"haltestellen" => [haltestelle1, haltestelle2]})

      assert {:ok, %Linie{} = linie} = Fahrplan.create_linie(valid_attrs_haltestellen)
      assert linie.name == "S6"

      assert Enum.map(linie.haltestellen, fn x -> x.name end) == [
               "Leverkusen Mitte",
               "Leverkusen Rheindorf"
             ]
    end

    test "create_linie/1 with invalid data" do
      assert {:error, %Ecto.Changeset{}} = Fahrplan.create_linie(@invalid_attrs)
    end
  end
end
