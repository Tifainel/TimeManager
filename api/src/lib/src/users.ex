defmodule Src.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Src.Repo

  alias Src.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
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
  def get_user!(id), do: Repo.get!(User, id)

  def user_exists(id) do
    query = from u in "users",
              where: u.id == ^String.to_integer(id),
              select: count(u.id)
    Repo.one(query)
  end

  def check_user_password(params) do
    pwd = :crypto.hash(:md5, params["password"]) |> Base.encode16()
    usrn = String.downcase(params["username"])
    query = from u in "users",
              where: u.username == ^usrn and u.password == ^pwd,
              select: [:id, :email, :username, :role]
    Repo.one(query)
  end

  def get_user_by_email_and_username(attrs) do
    query = from u in "users",
              where: u.email == ^String.downcase(attrs["email"]) and u.username == ^String.downcase(attrs["username"]),
              select: [:id, :email, :username, :role]
    Repo.one(query)
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
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
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
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

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
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias Src.Users.Team

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Team{}, ...]

  """
  def list_teams do
    Repo.all(Team)
  end

  @doc """
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id), do: Repo.get!(Team, id)

  @doc """
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a team.

  ## Examples

      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}

      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{data: %Team{}}

  """
  def change_team(%Team{} = team, attrs \\ %{}) do
    Team.changeset(team, attrs)
  end


  def get_team_by_user_id(user_id) do
    query = from t in "teams",
              where: t.user_id == ^String.to_integer(user_id),
              select: [:id, :user_id, :name, :members]
    Repo.all(query)
  end

  def get_team_by_user_and_team_id(attrs) do
    query = from t in "teams",
              where: t.user_id == ^String.to_integer(attrs["user_id"]) and t.id == ^String.to_integer(attrs["id"]),
              select: [:id, :user_id, :name, :members]
    Repo.one(query)
  end

  def get_teams_by_member(member_id) do
    query = from t in "teams",
              where: ^String.to_integer(member_id) == fragment("ANY(members)"),
              select: [:id, :user_id, :name, :members]
    Repo.all(query)

  end

  alias Src.Users.Role

  @doc """
  Returns the list of roles.

  ## Examples

      iex> list_roles()
      [%Role{}, ...]

  """
  def list_roles do
    Repo.all(Role)
  end

  @doc """
  Gets a single role.

  Raises `Ecto.NoResultsError` if the Role does not exist.

  ## Examples

      iex> get_role!(123)
      %Role{}

      iex> get_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role!(id), do: Repo.get!(Role, id)

  @doc """
  Creates a role.

  ## Examples

      iex> create_role(%{field: value})
      {:ok, %Role{}}

      iex> create_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a role.

  ## Examples

      iex> update_role(role, %{field: new_value})
      {:ok, %Role{}}

      iex> update_role(role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a role.

  ## Examples

      iex> delete_role(role)
      {:ok, %Role{}}

      iex> delete_role(role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking role changes.

  ## Examples

      iex> change_role(role)
      %Ecto.Changeset{data: %Role{}}

  """
  def change_role(%Role{} = role, attrs \\ %{}) do
    Role.changeset(role, attrs)
  end


  def get_role_user_list(role_id) do
    query = from u in "users",
              where: u.role == ^String.to_integer(role_id),
              select: [:id, :email, :username, :role]
    Repo.all(query)
  end

  alias Src.Users.Auth

  @doc """
  Returns the list of auths.

  ## Examples

      iex> list_auths()
      [%Auth{}, ...]

  """
  def list_auths do
    Repo.all(Auth)
  end

  @doc """
  Gets a single auth.

  Raises `Ecto.NoResultsError` if the Auth does not exist.

  ## Examples

      iex> get_auth!(123)
      %Auth{}

      iex> get_auth!(456)
      ** (Ecto.NoResultsError)

  """
  #def get_auth!(id), do: Repo.get!(Auth, id)

  @doc """
  Creates a auth.

  ## Examples

      iex> create_auth(%{field: value})
      {:ok, %Auth{}}

      iex> create_auth(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_auth(attrs \\ %{}) do
    %Auth{}
    |> Auth.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a auth.

  ## Examples

      iex> update_auth(auth, %{field: new_value})
      {:ok, %Auth{}}

      iex> update_auth(auth, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_auth(%Auth{} = auth, attrs) do
    auth
    |> Auth.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a auth.

  ## Examples

      iex> delete_auth(auth)
      {:ok, %Auth{}}

      iex> delete_auth(auth)
      {:error, %Ecto.Changeset{}}

  """
  def delete_auth(%Auth{} = auth) do
    Repo.delete(auth)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking auth changes.

  ## Examples

      iex> change_auth(auth)
      %Ecto.Changeset{data: %Auth{}}

  """
  def change_auth(%Auth{} = auth, attrs \\ %{}) do
    Auth.changeset(auth, attrs)
  end

  def set_auth(user_id, jwt, max) do
    if get_auth(jwt) == nil do
      today = NaiveDateTime.utc_now()
      expire_date = NaiveDateTime.add(today, max * 24 * 60 * 60)
      create_auth(%{user_id: user_id, token: jwt, expire_date: expire_date})
    end
  end

  def get_auth(jwt) do
    query = from a in "auths",
              where: a.token == ^jwt and a.expire_date > ^NaiveDateTime.utc_now(),
              select: [:id]
    Repo.one(query)
  end
end
