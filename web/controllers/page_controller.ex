defmodule NationalVoterFile.PageController do
  use NationalVoterFile.Web, :controller

  def index(conn, _params) do
    redirect conn, external: "http://www.nationalvoterfile.org/"
  end
end
