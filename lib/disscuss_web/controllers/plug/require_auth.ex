defmodule DisscussWeb.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias DisscussWeb.Router.Helpers

  def init(_param) do
  end

  def call(conn, _param) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in")
      |> redirect(to: Helpers.topic_path(conn, :index))
      |>  halt()
    end
  end
end
