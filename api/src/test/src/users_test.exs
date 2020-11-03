defmodule Src.UsersTest do
  use Src.DataCase

  alias Src.Users

  describe "roles" do
    alias Src.Users.Role

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def role_fixture(attrs \\ %{}) do
      {:ok, role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_role()

      role
    end

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert Users.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert Users.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      assert {:ok, %Role{} = role} = Users.create_role(@valid_attrs)
      assert role.name == "some name"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      assert {:ok, %Role{} = role} = Users.update_role(role, @update_attrs)
      assert role.name == "some updated name"
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_role(role, @invalid_attrs)
      assert role == Users.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Users.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Users.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Users.change_role(role)
    end
  end

  describe "users" do
    alias Src.Users.User

    @valid_attrs %{email: "some email", username: "some username", password: "84FE4741B37204D9F2FF3665811F449D"}
    @update_attrs %{email: "some updated email", username: "some updated username", password: "AC1EF17C2DB40995E9FDD40B04A5A649"}
    @invalid_attrs %{email: nil, username: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end

  describe "teams" do
    alias Src.Users.Team

    @valid_attrs %{members: []}
    @update_attrs %{members: []}
    @invalid_attrs %{members: nil}

    def team_fixture(attrs \\ %{}) do
      {:ok, team} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_team()

      team
    end

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Users.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Users.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      assert {:ok, %Team{} = team} = Users.create_team(@valid_attrs)
      assert team.members == []
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      assert {:ok, %Team{} = team} = Users.update_team(team, @update_attrs)
      assert team.members == []
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_team(team, @invalid_attrs)
      assert team == Users.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Users.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Users.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Users.change_team(team)
    end
  end

  describe "auths" do
    alias Src.Users.Auth

    @valid_attrs %{expire_date: "2010-04-17T14:00:00Z", token: "some token"}
    @update_attrs %{expire_date: "2011-05-18T15:01:01Z", token: "some updated token"}
    @invalid_attrs %{expire_date: nil, token: nil}

    def auth_fixture(attrs \\ %{}) do
      {:ok, auth} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_auth()

      auth
    end

    test "list_auths/0 returns all auths" do
      auth = auth_fixture()
      assert Users.list_auths() == [auth]
    end

    test "get_auth!/1 returns the auth with given id" do
      auth = auth_fixture()
      assert Users.get_auth!(auth.id) == auth
    end

    test "create_auth/1 with valid data creates a auth" do
      assert {:ok, %Auth{} = auth} = Users.create_auth(@valid_attrs)
      assert auth.expire_date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert auth.token == "some token"
    end

    test "create_auth/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_auth(@invalid_attrs)
    end

    test "update_auth/2 with valid data updates the auth" do
      auth = auth_fixture()
      assert {:ok, %Auth{} = auth} = Users.update_auth(auth, @update_attrs)
      assert auth.expire_date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert auth.token == "some updated token"
    end

    test "update_auth/2 with invalid data returns error changeset" do
      auth = auth_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_auth(auth, @invalid_attrs)
      assert auth == Users.get_auth!(auth.id)
    end

    test "delete_auth/1 deletes the auth" do
      auth = auth_fixture()
      assert {:ok, %Auth{}} = Users.delete_auth(auth)
      assert_raise Ecto.NoResultsError, fn -> Users.get_auth!(auth.id) end
    end

    test "change_auth/1 returns a auth changeset" do
      auth = auth_fixture()
      assert %Ecto.Changeset{} = Users.change_auth(auth)
    end
  end
end
