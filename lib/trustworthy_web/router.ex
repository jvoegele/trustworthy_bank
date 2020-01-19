defmodule TrustworthyWeb.Router do
  use TrustworthyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]

    plug Guardian.Plug.Pipeline,
      error_handler: TrustworthyWeb.ErrorHandler,
      module: Trustworthy.Auth.Guardian

    plug Guardian.Plug.VerifyHeader, realm: "Token"
    plug Guardian.Plug.LoadResource, allow_blank: true
  end

  scope "/api", TrustworthyWeb do
    pipe_through :api

    post "/users", UserController, :create
    get "/user", UserController, :current
    post "/users/login", SessionController, :create
  end

  scope "/", TrustworthyWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", TrustworthyWeb do
  #   pipe_through :api
  # end
end
