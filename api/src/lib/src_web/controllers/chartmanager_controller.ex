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
    clocks_out = ChartManager.get_clocks_out(user_id, Enum.at(clocks_in, 0)[:time])

    default_day_start = ~T[05:59:59]
    default_night_start = ~T[20:00:00]

    loop = Enum.count(clocks_in);


    #Total time
    totalNight = 0
    totalDay = 0
    counter = 0

    {counter, totalDay, totalNight} = while {counter, totalDay, totalNight}, counter < loop do


      Enum.at(clocks_in, counter)[:time]
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

  defp dt_extract_time(datetime) do
    Time.from_iso8601!(String.slice(NaiveDateTime.to_string(datetime), 11..26))
  end


  # alias
  @doc """
  Returns the list of users.
  """

  def time_per_days(conn, %{"user_id"=>user_id, "days"=>days}) do
    timeperdays = loop_for_every_day(user_id, days)
    conn
    |> put_status(:ok)
    |> json(timeperdays)
  end

  defp loop_for_every_day(user_id, days) do
    todayDate = Date.utc_today()
    minDate = Date.add(todayDate, - String.to_integer(days))

    # timeperdays = Map.new()
    timeperdays = []
    loopDate = minDate
    i = 0
    #while start
    {loopDate, timeperdays, i} = while {loopDate, timeperdays, i}, loopDate < todayDate do

      minDate = NaiveDateTime.from_iso8601!(Date.to_string(loopDate)<>"T00:00:00.000000Z")
      maxDate = NaiveDateTime.from_iso8601!(Date.to_string(loopDate)<>"T23:59:59.000000Z")

      # IO.inspect()
      day = ChartManager.get_daytime_data(user_id, minDate, maxDate)
      #IO.inspect(day)

      total = calc_time_per_day(day, minDate, maxDate)
      {
        Date.add(loopDate, 1),
        List.insert_at(timeperdays, i, %{"day"=>loopDate, "time"=>total}),
        i + 1
        #timeperdays = Map.put(timeperdays, loopDate, total)
      }
    end #while end
    timeperdays
  end

  defp calc_time_per_day(dayData, min, max) do
    #IO.inspect(dayData)
    total = 0
    counter = 0
    #while start
    {total, counter} = while {total, counter}, counter < Enum.count(dayData) do
      loopDate = Enum.at(dayData, counter)
      {t, c} = calculate_time(loopDate, min, max, counter, total, dayData)
      {total = total + t, counter = c}
    end #while end
    total
  end

  defp calculate_time(loopDate, min, max, counter, total, dayData) do
    c = counter + 1
    nextLoopDate = max
    next = Enum.at(dayData, c)
    if loopDate[:status] == true do
      if next != nil do
        nextLoopDate = next[:time]
        {NaiveDateTime.diff(nextLoopDate, loopDate[:time]), counter + 2}
      else
        {NaiveDateTime.diff(nextLoopDate, loopDate[:time]), counter + 1}
      end
      # {c + 2, t + 1}
    else
      if loopDate[:status] == false and counter == 0 do
        {NaiveDateTime.diff(loopDate[:time], min), counter + 1}
      else
        {0, counter + 1}
      end
      #{counter + 1, total + 1}
    end
  end


  def time_per_days_scheduled(conn, %{"user_id"=>user_id, "days"=>days}) do
    timeperdays = loop_for_every_day(user_id, days)

    scheduled = scheduled_workingtime(user_id, days)

    merged = []
    counter = 0
    #while start
    {counter, merged} = while {counter, merged}, counter < Enum.count(timeperdays) do
      l1 = Enum.at(timeperdays, counter)
      l2 = Enum.at(scheduled, counter)

      newMap = Map.merge(l1, l2)
      {
        counter + 1,
        List.insert_at(merged, counter, newMap),
      }

    end #while end

    conn
    |> put_status(:ok)
    |> json(merged)

  end

  defp scheduled_workingtime(user_id, days) do
    todayDate = Date.utc_today()
    minDate = Date.add(todayDate, - String.to_integer(days))

    # timeperdays = Map.new()
    timeperdays = []
    loopDate = minDate
    i = 0
    #while start
    {loopDate, timeperdays, i} = while {loopDate, timeperdays, i}, loopDate < todayDate do

      minDate = NaiveDateTime.from_iso8601!(Date.to_string(loopDate)<>"T00:00:00.000000Z")
      maxDate = NaiveDateTime.from_iso8601!(Date.to_string(loopDate)<>"T23:59:59.000000Z")

      # IO.inspect()
      day = ChartManager.get_dayworkingtime_data(user_id, minDate, maxDate)
      total = calc_scheduled_time_per_day(day, minDate, maxDate)
      {
        Date.add(loopDate, 1),
        List.insert_at(timeperdays, i, %{"day"=>loopDate, "scheduled"=>total}),
        i + 1
      }
      #il faut renvoyer le total ici putin de merde.
      # {
      #   Date.add(loopDate, 1),
      #   List.insert_at(timeperdays, i, %{"day"=>loopDate, "time"=>total}),
      #   i + 1
      #   #timeperdays = Map.put(timeperdays, loopDate, total)
      # }
    end #while end
    timeperdays

  end

  defp calc_scheduled_time_per_day(dayData, min, max) do
    #   #IO.inspect(dayData)
    total = 0
    counter = 0
    #while start
    {total, counter} = while {total, counter}, counter < Enum.count(dayData) do
      loopDate = Enum.at(dayData, counter)
      {t, c} = calculate_workingtime(loopDate, min, max, counter, total)
      {total = total + t, counter = c}
    end #while end
    total
  end
  #
  defp calculate_workingtime(loopDate, min, max, counter, total) do
    if loopDate[:start] > min do
      if loopDate[:end] < max do
        {NaiveDateTime.diff(loopDate[:end], loopDate[:start]), counter + 1}
      else
        {NaiveDateTime.diff(max, loopDate[:start]), counter + 1}
      end
    else
      {NaiveDateTime.diff(loopDate[:end], min), counter + 1}
    end
    # c = counter + 1
    # nextLoopDate = max
    # next = Enum.at(dayData, c)
    # if loopDate[:status] == true do
    #   if next != nil do
    #     nextLoopDate = next[:time]
    #     {NaiveDateTime.diff(nextLoopDate, loopDate[:time]), counter + 2}
    #   else
    #     {NaiveDateTime.diff(nextLoopDate, loopDate[:time]), counter + 1}
    #   end
    #   # {c + 2, t + 1}
    # else
    #   if loopDate[:status] == false and counter == 0 do
    #     {NaiveDateTime.diff(loopDate[:time], min), counter + 1}
    #   else
    #     {0, counter + 1}
    #   end
    #   #{counter + 1, total + 1}
    # end
  end

end
