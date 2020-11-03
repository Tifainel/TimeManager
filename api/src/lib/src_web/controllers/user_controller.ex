defmodule SrcWeb.UserController do
  use SrcWeb, :controller

  alias Src.Users
  alias Src.Users.User
  alias Src.Users.Auth

  action_fallback SrcWeb.FallbackController

  def get_user_by_username_email(conn, params) do
    user = Users.get_user_by_email_and_username(params)
    is_allowed(conn)
    if user !== nil do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    else
      conn
      |> put_status(:not_found)
      |> json(%{"Error"=>"User not found."})
    end
  end

  def create(conn, %{"user" => user_params}) do
    pwd = :crypto.hash(:md5, user_params["password"]) |> Base.encode16()
    user_params = Map.put(user_params, "password", pwd)
    user_params = Map.put(user_params, "username", String.downcase(user_params["username"]))
    user_params = Map.put(user_params, "email", String.downcase(user_params["email"]))
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    is_allowed(conn)
    render(conn, "show.json", user: user)
  end

  def sign_in(conn, params) do
    user = Users.check_user_password(params)
    if user == nil do
      conn
      |> put_status(:forbidden)
      |> json(%{"error"=>"Match error"})

    else
      token_config = %{} # empty config
      token_config = Map.put(token_config, "scope", %Joken.Claim{
        generate: fn -> "user" end,
        validate: fn val, _claims, _context -> val in ["user", "admin"] end
      })

      signer = Joken.Signer.create("HS256", "my secret")
      {:ok, claims} = Joken.generate_claims(token_config, %{"id"=> user[:id], "role"=>user[:role]})
      {:ok, jwt, claims} = Joken.encode_and_sign(claims, signer)

      Users.set_auth(user[:id], jwt, 30)
      conn
      |> put_status(:ok)
      |> json(%{"token"=>jwt})
    end


  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    is_allowed(conn)
    user = Users.get_user!(id)
    current_password = Map.fetch!(user, :password)
    user_params = if current_password !== user_params["password"] do
      pwd = :crypto.hash(:md5, user_params["password"]) |> Base.encode16()
      Map.put(user_params, "password", pwd)
    else
      user_params
    end
    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end

  end

  def delete(conn, %{"id" => id}) do
    is_allowed(conn)
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
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
