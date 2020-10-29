defmodule Src.ChartManager do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Src.Repo

  # alias Src.Users.User

  @doc """
  Returns the list of users.
  """
  def get_daytime_data(user_id, min_date, max_date) do
    query = from c in "clocks",
              where: c.user_id == ^String.to_integer(user_id) and c.time > ^min_date and c.time < ^max_date,
              select: [:id, :time, :status]
    Repo.all(query)
  end

  def get_dayworkingtime_data(user_id, min_date, max_date) do
    query = from w in "workingtimes",
              where: w.user_id == ^String.to_integer(user_id) and (w.start > ^min_date or w.end > ^min_date) and w.start < ^max_date,
              select: [:id, :start, :end]
    Repo.all(query)
  end

  def get_clocks_in(user_id, days) do
    date = NaiveDateTime.utc_now()
    minDate = NaiveDateTime.add(date, - String.to_integer(days) * 24 * 60 * 60)

    query = from c in "clocks",
              where: c.user_id == ^String.to_integer(user_id) and c.time > ^minDate and c.status == "true",
              order_by: [asc: c.time],
              select: [:id, :time, :status]
    Repo.all(query)
  end

  def get_clocks_out(user_id, minDate) do
    date = NaiveDateTime.utc_now()

    query = from c in "clocks",
              where: c.user_id == ^String.to_integer(user_id) and c.time > ^minDate and c.status == "false",
              order_by: [asc: c.time],
              select: [:id, :time, :status]
    Repo.all(query)
  end

end
