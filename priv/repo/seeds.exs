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
Repo.insert!(%User{name: "peng"})
Repo.insert!(%Task{title: "task1", description: "des1", finished: false, time: 0, user: %User{name: "User2"}})
