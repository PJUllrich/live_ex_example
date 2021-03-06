defmodule LiveViewTestWeb.Router do
  use Phoenix.Router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveViewTestWeb do
    pipe_through :browser

    live "/", IndexLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveViewTestWeb do
  #   pipe_through :api
  # end
end
