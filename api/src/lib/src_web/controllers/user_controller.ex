defmodule SrcWeb.UserController do
  use SrcWeb, :controller

  alias Src.Users
  alias Src.Users.User

  action_fallback SrcWeb.FallbackController

  def index(conn, params) do
    user = Users.get_user_by_email_and_username(params)
    render(conn, "user.json", user: user)
  end

  def create(conn, %{"user" => user_params}) do
    # IO.inspect(user_params)
    # %{user_params | password: "d"}
    #   IO.inspect(user_params)
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    IO.inspect(user)
    render(conn, "show.json", user: user)
  end

  def sign_in(conn, params) do
    user = Users.check_user_password(params)

    token_config = %{} # empty config
    token_config = Map.put(token_config, "scope", %Joken.Claim{
      generate: fn -> "user" end,
      validate: fn val, _claims, _context -> val in ["user", "admin"] end
    })

    signer = Joken.Signer.create("HS256", "my secret")
    {:ok, claims} = Joken.generate_claims(token_config, %{"id"=> user[:id], "role"=>user[:role]})
    {:ok, jwt, claims} = Joken.encode_and_sign(claims, signer)

    conn
    |> put_status(:ok)
    |> json(%{"token"=>jwt})
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
