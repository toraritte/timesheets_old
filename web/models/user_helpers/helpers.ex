defmodule Timesheets.User.Helpers do
  # TODO: this could probably to to postgres itself
  #       as a special view or something
  def name_for_file_and_path(name) do
    name
    |> String.downcase
    |> String.replace(~r/[.,\s]+/, "_")
  end
end
