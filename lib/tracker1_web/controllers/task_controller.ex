defmodule Tracker1Web.TaskController do
  use Tracker1Web, :controller
  import Ecto.Query
  alias Tracker1.Tasks
  alias Tracker1.Tasks.Task
  alias Tracker1.Users
  alias Tracker1.Repo
  alias Tracker1.Timeblocks


  def index(conn, _params) do
    tasks = Tasks.list_visible_task(conn.assigns.current_user.id)
    times = Enum.reduce(tasks, %{}, fn t, acc -> Map.put(acc, t.id, calc_time(t.id)) end)
    render(assign(conn, :times, times), "index.html", tasks: tasks)
  end

  defp calc_time(task_id) do
    blocks = Timeblocks.get_time_timeblock_by_taskid(task_id)
    time = round(Enum.sum(Enum.map(blocks, fn t -> DateTime.diff(t.end, t.start) end))/60)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    users = Users.list_users()
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.puts("error")
        users = Users.list_underlings(conn.assigns.current_user.id)
        render(conn, "new.html", changeset: changeset, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    blocks = Timeblocks.get_time_timeblock_by_taskid(id)
    IO.inspect(blocks)
    render(conn, "show.html", task: task, timeblocks: blocks)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    users = Users.list_underlings(conn.assigns.current_user.id) ++ [conn.assigns.current_user]
    render(conn, "edit.html", task: task, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    IO.inspect(task_params)
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end


  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end

end
