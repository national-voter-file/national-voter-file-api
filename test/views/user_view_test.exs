defmodule NationalVoterFile.UserViewTest do
  use NationalVoterFile.ViewCase

  alias Phoenix.ConnTest
  alias Plug.Conn

  test "renders properly" do
    user = insert(:user)

    rendered_json = render(NationalVoterFile.UserView, "show.json-api", data: user)

    expected_json = %{
      "data" => %{
        "id" => user.id |> Integer.to_string,
        "type" => "user",
        "attributes" => %{
          "email" => "",
          "inserted-at" => user.inserted_at,
          "updated-at" => user.updated_at
        }
      },
      "jsonapi" => %{
        "version" => "1.0"
      }
    }

    assert rendered_json == expected_json
  end

  test "renders email when user is the authenticated user" do
    user = insert(:user)

    conn =
      ConnTest.build_conn()
      |> Conn.assign(:current_user, user)

    rendered_json = render(NationalVoterFile.UserView, "show.json-api", data: user, conn: conn)
    assert rendered_json["data"]["attributes"]["email"] == user.email
  end

  test "renders email for only the authenticated user when rendering list" do
    users = insert_list(4, :user)
    auth_user = users |> List.last

    conn =
      ConnTest.build_conn()
      |> Conn.assign(:current_user, auth_user)

    rendered_json = render(NationalVoterFile.UserView, "show.json-api", data: users, conn: conn)

    emails =
      rendered_json["data"]
      |> Enum.map(&Map.get(&1, "attributes"))
      |> Enum.map(&Map.get(&1, "email"))
      |> Enum.filter(fn(email) -> email != "" end)

    assert emails == [auth_user.email]
  end
end
