defmodule Timesheets.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name,      :string
      add :title,     :string
      add :sig_path,  :string

      timestamps()
    end
  end
end
