defmodule Timesheets.TimesheetView do
  use Timesheets.Web, :view

  def first_name(name) do
    name
    |> String.split()
    |> hd
  end

  def format_regular_hrs(r) do

    regular_hrs =  String.split(r, ~r/[^:\d]/, trim: true)
    cycle =        ~w(am_start am_end pm_start pm_end)

    Enum.zip(cycle, regular_hrs)
  end

  def humanize_time(str) do
    case str do
      "am_start" -> "AM start time"
      "am_end"   -> "AM end time"
      "pm_start" -> "PM start time"
      "pm_end"   -> "PM end time"
    end
  end

  def create_id(time_str, period_date) do
    String.to_atom("#{period_date.excel_date}_#{time_str}")
  end

  def others do
    text =
      ["Overtime",
       "Bereavement/Jury duty",
       "Holiday",
       "Personal holiday",
       "Paid time off",
       "Paid day off"
      ]
      |> Enum.map(&String.to_atom(&1))

    value = ~w(ot bjd hol ph pto pdo)

    Enum.zip(text,value)
  end

  def special_day_attributes(period_date, regular_hrs) do
    # Based on the payroll calendar, holidays and weekends
    # are mutually exclusive.
    select_opts = [prompt: "Select one or leave as it is"]
    others_opts = [placeholder: "duration, e.g., 8"]

    weekend? = String.match?(period_date.pretty_date, ~r/^(Saturday|Sunday)/)
    holiday? = period_date.is_holiday?

    case weekend? do
      true  ->
        {"0:00-0:00,0:00-0:00", select_opts,       others_opts }
      false ->
        case holiday? do
          true  ->
            {"0:00-0:00,0:00-0:00", [selected: "hol"], [value: "8"]}
          false ->
            {regular_hrs,           select_opts,       others_opts }
        end
    end
  end
end
