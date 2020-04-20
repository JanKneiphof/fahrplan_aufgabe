defmodule FahrplanDb.HaltestelleTest do
  use FahrplanDb.DataCase

  alias FahrplanDb.Haltestelle
  alias FahrplanDb.Fahrplan
  alias FahrplanDb.Linie

  describe "haltestelle" do
    @valid_attrs %{name: "Leverkusen Mitte"}
    @invalid_attrs %{name: ""}

    test "create_haltestelle/1 with valid data" do
      assert {:ok, %Haltestelle{} = haltestelle} = Fahrplan.create_haltestelle(@valid_attrs)
      assert haltestelle.name == "Leverkusen Mitte"
    end

    test "create_haltestelle/1 with invalid data" do
      assert {:error, %Ecto.Changeset{}} = Fahrplan.create_haltestelle(@invalid_attrs)
    end
  end
end
