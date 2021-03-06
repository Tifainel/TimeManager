defmodule SrcWeb.ClockController do
  use SrcWeb, :controller

  alias Src.Time
  alias Src.Time.Clock
  alias Src.Users

  action_fallback SrcWeb.FallbackController

  def index(conn, _params) do
    is_allowed(conn)
    clocks = Time.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"user_id"=>user_id, "clock"=>clock_params}) do
    is_allowed(conn)

    user_exists = Users.user_exists(user_id)
    if user_exists > 0 do
      clock_params = Map.put(clock_params, "user_id", user_id)
      with {:ok, %Clock{} = clock} <- Time.create_clock(%{"clock"=>clock_params}) do
        conn
        |> put_status(:created)
        |> render("show.json", clock: clock)
      end
    else
      conn
      |> put_status(:not_found)
      |> json(%{"Error"=>"User not found."})
    end
  end

  def show(conn, user_id) do
    is_allowed(conn)
    clocks = Time.get_clock_by_user_id(user_id)
    conn
    |> put_status(:ok)
    |> json(clocks)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    is_allowed(conn)
    clock = Time.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Time.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    is_allowed(conn)
    clock = Time.get_clock!(id)

    with {:ok, %Clock{}} <- Time.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_last_by_user_id(conn, %{"user_id"=>user_id}) do
    is_allowed(conn)
    # IO.inspect(user_id)
    clock = Time.get_last_clock_user_id(user_id)

    # IO.inspect(clock)
    render(conn, "clock.json", clock: clock)
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
