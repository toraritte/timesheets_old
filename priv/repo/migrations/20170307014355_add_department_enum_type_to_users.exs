defmodule Timesheets.Repo.Migrations.AddDepartmentEnumTypeToUsers do
  use Ecto.Migration
  alias Timesheets.User.Helpers.DepartmentEnum

  def up do
    DepartmentEnum.create_type()
    alter table(:users) do
      add :department, :department
    end
  end

  def down do
    alter table(:users) do
      remove :department
    end
    DepartmentEnum.drop_type()
  end
end
