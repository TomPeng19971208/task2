defmodule Tracker1.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :description, :string
    field :finished, :boolean, default: false
    field :time, :integer
    field :title, :string
    belongs_to :user, Tracker1.Users.User
    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :finished, :time, :user_id])
    |> validate_required([:title, :description, :finished, :time])
    |> validate_time(:time)
  end

  defp validate_time(task, :time) do
    validate_change task, :time, fn :time, time  ->
      if rem(time, 15) == 0 do
        []
      else
        [:time,  "Must be a multiple of 15"]
      end
    end
  end
end
