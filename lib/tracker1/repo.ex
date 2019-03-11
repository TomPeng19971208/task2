defmodule Tracker1.Repo do
  use Ecto.Repo,
    otp_app: :tracker1,
    adapter: Ecto.Adapters.Postgres
end
