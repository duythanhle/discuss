defmodule DisscussWeb.PageController do
  use DisscussWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
