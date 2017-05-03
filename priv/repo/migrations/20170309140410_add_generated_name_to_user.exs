defmodule Timesheets.Repo.Migrations.AddGeneratedNameToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name_for_file_and_path, :string
    end
  end
end
