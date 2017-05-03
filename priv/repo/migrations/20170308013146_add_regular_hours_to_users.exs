defmodule Timesheets.Repo.Migrations.AddRegularHoursToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :regular_hrs, :string
    end
  end
end
