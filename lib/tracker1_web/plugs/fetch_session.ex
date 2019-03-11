#get this code from nat's lecture notes
defmodule Tracker1Web.Plugs.FetchSession do
  import Plug.Conn
  alias Tracker1.Users

  def init(args), do: args

  def call(conn, _args) do
    user = Users.get_user(get_session(conn, :user_id) || -1)
    if user do
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end
end
