defmodule Tracker1.Timeblocks.Timeblock do
  use Ecto.Schema
  import Ecto.Changeset


  schema "timeblocks" do
    field :end, :utc_datetime
    field :start, :utc_datetime
    belongs_to :task, Tracker1.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(timeblock, attrs) do
    timeblock
    |> cast(attrs, [:start, :end, :task_id])
    |> validate_required([:start, :end])
  end
end
