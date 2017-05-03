defmodule Timesheets.UserController do
  use Timesheets.Web, :controller
  alias Timesheets.User.Helpers

  require IEx

  def new(conn, _params) do
    changeset = Timesheets.User.changeset(%Timesheets.User{})
    render conn, "user.html",
           # assigns
           changeset:    changeset,
           departments:  Helpers.DepartmentEnum.__enum_map__()
  end

  # TODO: add validation!
  #       Hoping that the redundant todos will take care of this by magic...
  def create(conn, %{"user" => user}) do
    %{"name"       => name,
      "signature"  => signature} = user

    # save uploaded signature
    new_name = Helpers.name_for_file_and_path(name)
    new_filename = "#{new_name}_#{signature.filename}"
    sig_path = "/home/toraritte/Documents/#{new_filename}"

    toDB = user
           |> Map.drop(["signature"])
           |> Map.put("sig_path", sig_path)
           |> Map.put("name_for_file_and_path", new_name)

    changeset = Timesheets.User.changeset(%Timesheets.User{}, toDB)

    # TODO: add flash messages to show error or success
    #       The success message before I forget:
    #       "Please bookmark this page and next time you just have to visit it to fill out your timesheet."
    #       (... or something along these lines.)
    case Repo.insert(changeset) do

      {:ok, _user} ->
        File.rename( signature.path, sig_path)
        redirect conn, to: timesheet_path(conn, :show, new_name)

      {:error, changeset} ->
        IO.inspect changeset.valid?
        IO.inspect changeset.errors
        render(conn, "setup.html", changeset: changeset)
    end
  end
end

# pry(1)> params
# %{"_csrf_token" => "HTVnMiQ9ZngyHmEEA1g/A30wRgUgNgAArmWSGHT7bY9bS6Jy4EuOXQ==",
#   "_utf8" => "✓",
#   "user" => %{"name" => "a",
#     "signature" => %Plug.Upload{content_type: "application/vnd.ms-excel",
#      filename: "agulyas_timeoff-request for 11-28-2016.xls",
#      path: "/tmp/plug-1488/multipart-779769-127108-1"}, "title" => "b"}}
