defmodule Timesheets.Router do
  use Timesheets.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Timesheets do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/user",      UserController,      only: [:new,  :create]
    resources "/timesheet", TimesheetController, only: [:show,  :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Timesheets do
  #   pipe_through :api
  # end
end
