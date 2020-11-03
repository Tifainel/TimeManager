defmodule SrcWeb.AuthController do
  use SrcWeb, :controller

  alias Src.Users
  alias Src.Users.Auth

  action_fallback SrcWeb.FallbackController

  def index(conn, _params) do
    auths = Users.list_auths()
    render(conn, "index.json", auths: auths)
  end

  def create(conn, %{"auth" => auth_params}) do
    with {:ok, %Auth{} = auth} <- Users.create_auth(auth_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.auth_path(conn, :show, auth))
      |> render("show.json", auth: auth)
    end
  end

  def show(conn, %{"id" => id}) do
    auth = Users.get_auth!(id)
    render(conn, "show.json", auth: auth)
  end

  def update(conn, %{"id" => id, "auth" => auth_params}) do
    auth = Users.get_auth!(id)

    with {:ok, %Auth{} = auth} <- Users.update_auth(auth, auth_params) do
      render(conn, "show.json", auth: auth)
    end
  end

  def delete(conn, %{"id" => id}) do
    auth = Users.get_auth!(id)

    with {:ok, %Auth{}} <- Users.delete_auth(auth) do
      send_resp(conn, :no_content, "")
    end
  end

end
