defmodule NationalVoterFile.PageController do
  use NationalVoterFile.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
