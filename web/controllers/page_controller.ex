defmodule Timesheets.PageController do
  use Timesheets.Web, :controller

  def index(conn, %{"ts" => %{"id" => name}}) do
    redirect conn, to: timesheet_path(conn, :show, name)
  end
  def index(conn, _params) do
    render conn, "index.html", select_users: select_users()
  end

  defp select_users do
    query = from e in Timesheets.User, select: {e.name, e.name_for_file_and_path}
    Repo.all(query)
  end
end
