defmodule Tracker1Web.Router do
  use Tracker1Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Tracker1Web.Plugs.FetchSession
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Tracker1Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/sessions", SessionController, only: [:create, :delete], singleton: true
    resources "/users", UserController
    resources "/tasks", TaskController
  end

  # Other scopes may use custom stacks.
  # scope "/api", TrackerWeb do
  #   pipe_through :api
  # end
end
