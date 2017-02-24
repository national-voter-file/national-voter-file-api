defmodule NationalVoterFile.UserController do
  use NationalVoterFile.Web, :controller
  use JaResource

  import NationalVoterFile.Helpers.Query, only: [id_filter: 2, limit_filter: 2]

  alias NationalVoterFile.User

  plug JaResource
  plug :login, only: [:create]

  def filter(_conn, query, "id", id_list) do
    query |> id_filter(id_list)
  end

  def handle_index(_conn, params) do
    User
    |> limit_filter(params)
  end

  def handle_create(_conn, attributes) do
    %User{} |> User.registration_changeset(attributes)
  end

  defp login(conn, _opts) do
    Plug.Conn.register_before_send(conn, &do_login(&1))
  end

  defp do_login(conn), do: Plug.Conn.assign(conn, :current_user, conn.assigns[:data])
end
