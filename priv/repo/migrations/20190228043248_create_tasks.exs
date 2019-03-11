defmodule Tracker1.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :string, null: false
      add :time, :integer, null: false, default: 0
      add :finished, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:tasks, [:user_id])
  end
end
