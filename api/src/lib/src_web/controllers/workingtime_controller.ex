defmodule SrcWeb.WorkingtimeController do
  use SrcWeb, :controller

  alias Src.Time
  alias Src.Time.Workingtime
  alias Src.Users

  action_fallback SrcWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Time.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, workingtime_params) do
    user_exists = Users.user_exists(workingtime_params["user_id"])
    if user_exists == 1 do
      with {:ok, %Workingtime{} = workingtime} <- Time.create_workingtime(workingtime_params) do
        conn
        |> put_status(:created)
       # |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
        |> render("show.json", workingtime: workingtime)
      end
    else
      conn
      |> put_status(:not_found)
      |> json(%{"Error"=>"User not found."})
    end
  end

  def show(conn, %{"id" => id}) do
    workingtime = Time.get_workingtime!(id)
    render(conn, "show.json", workingtime: workingtime)
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Time.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Time.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Time.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Time.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_one(conn, params) do

    workingtime = Time.get_one_workingtime(params)

    if workingtime == nil do
      conn
      |> put_status(:not_found)
      |> json(%{"Error"=>"Unknown workingtime."})
    else
      conn
      |> put_status(:ok)
      |> render("workingtime.json", workingtime: workingtime)
    end

  end

  def get_all(conn, params) do
    if params["start"] !== nil and params["end"] !== nil do
      workingtimes = Time.get_all_workingtime(params)
      conn
      |> put_status(:ok)
      |> json(workingtimes)
    else
      conn
      |> put_status(:not_found)
      |> json(%{"Error"=>"Start and End datetimes must be set."})
    end
  end
end
