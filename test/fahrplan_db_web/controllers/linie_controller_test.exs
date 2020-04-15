defmodule FahrplanDbWeb.LinieControllerTest do
  use FahrplanDbWeb.ConnCase

  alias FahrplanDb.Fahrplan

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:linie) do
    {:ok, linie} = Fahrplan.create_linie(@create_attrs)
    linie
  end

  describe "index" do
    test "lists all linien", %{conn: conn} do
      conn = get(conn, Routes.linie_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Linien"
    end
  end

  describe "new linie" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.linie_path(conn, :new))
      assert html_response(conn, 200) =~ "New Linie"
    end
  end

  describe "create linie" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.linie_path(conn, :create), linie: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.linie_path(conn, :show, id)

      conn = get(conn, Routes.linie_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Linie"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.linie_path(conn, :create), linie: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Linie"
    end
  end

  describe "edit linie" do
    setup [:create_linie]

    test "renders form for editing chosen linie", %{conn: conn, linie: linie} do
      conn = get(conn, Routes.linie_path(conn, :edit, linie))
      assert html_response(conn, 200) =~ "Edit Linie"
    end
  end

  describe "update linie" do
    setup [:create_linie]

    test "redirects when data is valid", %{conn: conn, linie: linie} do
      conn = put(conn, Routes.linie_path(conn, :update, linie), linie: @update_attrs)
      assert redirected_to(conn) == Routes.linie_path(conn, :show, linie)

      conn = get(conn, Routes.linie_path(conn, :show, linie))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, linie: linie} do
      conn = put(conn, Routes.linie_path(conn, :update, linie), linie: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Linie"
    end
  end

  describe "delete linie" do
    setup [:create_linie]

    test "deletes chosen linie", %{conn: conn, linie: linie} do
      conn = delete(conn, Routes.linie_path(conn, :delete, linie))
      assert redirected_to(conn) == Routes.linie_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.linie_path(conn, :show, linie))
      end
    end
  end

  defp create_linie(_) do
    linie = fixture(:linie)
    {:ok, linie: linie}
  end
end
