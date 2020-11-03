defmodule SrcWeb.RoleController do
  use SrcWeb, :controller

  alias Src.Users
  alias Src.Users.Role

  action_fallback SrcWeb.FallbackController

  def index(conn, _params) do
    is_allowed(conn)
    roles = Users.list_roles()
    render(conn, "index.json", roles: roles)
  end

  def create(conn, %{"role" => role_params}) do
    is_allowed(conn)
    with {:ok, %Role{} = role} <- Users.create_role(role_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.role_path(conn, :show, role))
      |> render("show.json", role: role)
    end
  end

  def show(conn, %{"id" => id}) do
    is_allowed(conn)
    role = Users.get_role!(id)
    render(conn, "show.json", role: role)
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    is_allowed(conn)
    role = Users.get_role!(id)

    with {:ok, %Role{} = role} <- Users.update_role(role, role_params) do
      render(conn, "show.json", role: role)
    end
  end

  def delete(conn, %{"id" => id}) do
    is_allowed(conn)
    role = Users.get_role!(id)

    with {:ok, %Role{}} <- Users.delete_role(role) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_role_user_list(conn, %{"id"=>id}) do
    is_allowed(conn)
    user_list = Users.get_role_user_list(id)
    conn
    |> put_status(:ok)
    |> json(user_list)
  end

  def is_allowed(conn) do
    test = get_req_header(conn, "authorization")
    if Users.get_auth(String.slice("#{test}", 7..999)) != nil do
      true
    else
      conn
      |> put_status(:forbidden)
      |> json(%{"error"=>"Not allowed"})
    end
  end
end
