# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tracker1.Repo.insert!(%Tracker1.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Tracker1.Repo
alias Tracker1.Users.User
alias Tracker1.Tasks.Task
alias Tracker1.Timeblocks.Timeblock
u = Repo.insert!(%User{name: "under"})
u2 = Repo.insert!(%User{name: "under2"})
h = Repo.insert!(%User{name: "head"})
peng = Repo.insert!(%User{name: "peng", managers: [h], underlings: [u, u2]})
Repo.insert!(%Timeblock{start: DateTime.truncate(DateTime.utc_now(), :second),
end: DateTime.truncate(DateTime.utc_now(), :second),
 task: %Task{title: "task_peng", description: "des1", finished: false, time: 0, user: peng}})
Repo.insert!(%Task{title: "under_task1", description: "des1", finished: false, time: 0, user: u})
Repo.insert!(%Task{title: "under_task2", description: "des1", finished: false, time: 0, user: u2})
Repo.insert!(%Task{title: "head_task", description: "des1", finished: false, time: 0, user: h})
Repo.insert!(%Task{title: "self_task", description: "des1", finished: false, time: 0, user: peng})
