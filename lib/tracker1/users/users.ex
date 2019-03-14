defmodule Tracker1.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Tracker1.Repo

  alias Tracker1.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
    |> Repo.preload([:tasks, :managers, :underlings])
  end

  def list_underlings(id) do
    user = get_user(id)
    user.underlings
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    Repo.get!(User, id)
  end

  def get_user(id) do
    Repo.one from p in User,
      where: p.id == ^id,
      preload: [:tasks, :managers, :underlings]
  end

  def get_user_by_name(name) do
    Repo.get_by(User, name: name)
  end
  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    managers_id = Enum.map(attrs["managers"], fn x -> String.to_integer(x) end)
    underlings_id = Enum.map(attrs["underlings"], fn x -> String.to_integer(x) end)
    users = list_users()
    managers = Enum.filter(users, fn u -> u.id in managers_id end)
    underlings = Enum.filter(users, fn u -> u.id in underlings_id end)
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert!
    |> Repo.preload([:managers, :underlings])
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:managers, managers)
    |> Ecto.Changeset.put_assoc(:underlings, underlings)
    |> Repo.update
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    managers_id = Enum.map(attrs["managers"], fn x -> String.to_integer(x) end)
    underlings_id = Enum.map(attrs["underlings"], fn x -> String.to_integer(x) end)
    users = list_users()
    managers = Enum.filter(users, fn u -> u.id in managers_id end)
    underlings = Enum.filter(users, fn u -> u.id in underlings_id end)
    user
    |> User.changeset(attrs)
    |> Repo.update!
    |> Repo.preload([:managers, :underlings])
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:managers, managers)
    |> Ecto.Changeset.put_assoc(:underlings, underlings)
    |> Repo.update
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{managers: [], underlings: []})
  end
end
