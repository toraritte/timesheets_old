defmodule Timesheets.User do
  use Timesheets.Web, :model
  alias Timesheets.User.Helpers.DepartmentEnum

  schema "users" do
    field :name,                    :string
    field :title,                   :string
    field :sig_path,                :string
    field :department,              DepartmentEnum
    field :regular_hrs,             :string
    field :name_for_file_and_path,  :string

    timestamps()
  end

  @required_fields [:name, :title, :sig_path, :department, :regular_hrs, :name_for_file_and_path]

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
