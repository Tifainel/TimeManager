defmodule SrcWeb.ChartManagerController do
  use SrcWeb, :controller

  alias Src.ChartManager
  import While

  action_fallback SrcWeb.FallbackController

  def index(conn, _params) do
    # clocks = Time.list_clocks()
    # render(conn, "index.json", clocks: clocks)

  end

  def day_night_data(conn, %{"user_id"=>user_id, "days"=>days}) do
    clocks_in = ChartManager.get_clocks_in(user_id, days)
    clocks_out = ChartManager.get_clocks_out(user_id, days)

    default_day_start = ~T[05:59:59]
    default_night_start = ~T[20:00:00]

    IO.inspect(clocks_in)
    IO.inspect(clocks_out)

    loop = Enum.count(clocks_in);


    #Total time
    totalNight = 0
    totalDay = 0
    counter = 0

    {counter, totalDay, totalNight} = while {counter, totalDay, totalNight}, counter < loop do

      #Get the dates
      dateStart = Enum.at(clocks_in, counter)[:time]
      dateEnd = Enum.at(clocks_out, counter)[:time]

      #get the times from date
      timeStart = dt_extract_time(dateStart)
      timeEnd = dt_extract_time(dateEnd)


      if dateStart < dateEnd do
        if timeStart > default_day_start and timeStart < default_night_start do
          {counter + 1, totalDay + NaiveDateTime.diff(dateEnd, dateStart), totalNight + 0}
        else
          {counter + 1, totalDay + 0, totalNight + NaiveDateTime.diff(dateEnd, dateStart)}
        end
      end
    end

    conn
    |> put_status(:ok)
    |> json(%{"totalNight"=>totalNight, "totalDay"=>totalDay})
  end

  def dt_extract_time(datetime) do
    Time.from_iso8601!(String.slice(NaiveDateTime.to_string(datetime), 11..26))
  end

end
