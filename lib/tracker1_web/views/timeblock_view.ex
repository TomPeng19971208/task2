defmodule Tracker1Web.TimeblockView do
  use Tracker1Web, :view
  alias Tracker1Web.TimeblockView

  def render("index.json", %{timeblocks: timeblocks}) do
    %{data: render_many(timeblocks, TimeblockView, "timeblock.json")}
  end

  def render("show.json", %{timeblock: timeblock}) do
    %{data: render_one(timeblock, TimeblockView, "timeblock.json")}
  end

  def render("timeblock.json", %{timeblock: timeblock}) do
    %{id: timeblock.id,
      start: timeblock.start,
      end: timeblock.end}
  end
end
