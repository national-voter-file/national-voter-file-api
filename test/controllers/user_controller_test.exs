defmodule NationalVoterFile.UserControllerTest do
  use NationalVoterFile.ApiCase, resource_name: :user

  @valid_attrs %{
    email: "test@user.com"
  }

  @invalid_attrs %{
    email: ""
  }

  describe "index" do
    test "lists all entries on index", %{conn: conn} do
      [user_1, user_2] = insert_pair(:user)

      conn
      |> request_index
      |> json_response(200)
      |> assert_ids_from_response([user_1.id, user_2.id])
    end

    test "filters resources on index", %{conn: conn} do
      [user_1, user_2 | _] = insert_list(3, :user)

      path = "users/?filter[id]=#{user_1.id},#{user_2.id}"

      conn
      |> get(path)
      |> json_response(200)
      |> assert_ids_from_response([user_1.id, user_2.id])
    end

    test "limit filter limits results on index", %{conn: conn} do
      insert_list(6, :user)

      params = %{"limit" => 5}
      path = conn |> user_path(:index, params)
      json = conn |> get(path) |> json_response(200)

      returned_users_length = json["data"] |> length
      assert returned_users_length == 5
    end
  end

  describe "show" do
    test "shows chosen resource", %{conn: conn} do
      user = insert(:user)
      conn
      |> request_show(user)
      |> json_response(200)
      |> Map.get("data")
      |> assert_result_id(user.id)
    end

    @tag :authenticated
    test "renders email when authenticated", %{conn: conn, current_user: current_user} do
      assert conn |> request_show(current_user) |> json_response(200)
    end

    test "renders 404 when id is nonexistent", %{conn: conn} do
      assert conn |> request_show(:not_found) |> json_response(404)
    end
  end

  describe "create" do
    test "creates and renders resource when data is valid", %{conn: conn} do
      attrs = Map.put(@valid_attrs, :password, "password")
      conn = post conn, user_path(conn, :create), %{
        "data" => %{
          "attributes" => attrs
        }
      }

      assert conn |> json_response(201)
    end

    test "does not create resource and renders errors when data is invalid", %{conn: conn} do
      attrs = Map.put(@invalid_attrs, :password, "password")
      conn = post conn, user_path(conn, :create), %{
        "data" => %{
          "attributes" => attrs
        }
      }

      assert conn |> json_response(422)
    end
  end
end
