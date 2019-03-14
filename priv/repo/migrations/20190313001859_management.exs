defmodule Tracker1.Repo.Migrations.Management do
  use Ecto.Migration

  def change do
    create table("management") do
      add :manager_id, references(:users, on_delete: :delete_all), null: false
      add :underling_id, references(:users, on_delete: :delete_all), null: false
    end

    create index(:management, [:manager_id])
  end
end
