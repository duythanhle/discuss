defmodule DisscussWeb.Plugs.SetUser do
  import Plug.Conn

  alias Disscuss.Repo
  alias Disscuss.User

  def init(_param) do
  end

  def call(conn, _param) do
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user)
      true ->
        assign(conn, :user, nil)
    end
  end
end
