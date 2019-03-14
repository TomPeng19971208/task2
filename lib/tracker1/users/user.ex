defmodule Tracker1.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :name, :string
    has_many :tasks, Tracker1.Tasks.Task

    many_to_many :managers, Tracker1.Users.User,
    join_through: "management",
    join_keys: [underling_id: :id, manager_id: :id],
    on_replace: :delete

    many_to_many :underlings, Tracker1.Users.User,
    join_through: "management",
    join_keys: [manager_id: :id, underling_id: :id],
    on_replace: :delete
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
