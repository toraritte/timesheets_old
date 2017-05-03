defmodule Timesheets.TimesheetController do
  use Timesheets.Web, :controller

  def show(conn, %{"id" => name_for_file_and_path}) do
    user =
      Timesheets.User
      |> Repo.get_by(name_for_file_and_path: name_for_file_and_path)

    p =
      # PayrollDate.get_payroll_period("12/23/2017")
      # PayrollDate.get_payroll_period("2/17/2017")
      PayrollDate.get_payroll_period("5/17/2017")
      # Excel.Date.get_date_from_console
      # |> PayrollDate.get_payroll_period

    render conn, "timesheet.html", user: user, pdate: p
  end

  def create(conn, params) do
    require IEx
    IEx.pry
    show(conn, %{"id" => "lofasz_joska"})
  end
end
