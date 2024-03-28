defmodule TaskOptimized do
  # use GenServer
  require Logger
  import MyFile

  def compute_products(0) do
    _ = 1*1000
  end

  # function to compute with different
  def compute_products(n) do
    _ = 1*1000
    compute_products(n-1)
  end



  def run do
    processes = [1, 2, 3, 4, 5, 6, 7, 8, 16, 24, 32, 40, 48, 120, 160, 240, 280, 320, 360, 400]
    productsnumber = 10001
    step = 500

    for proc <- processes do
      for comp <- 1..productsnumber//step do
        before_operations = :erlang.memory()[:total]
        {:ok, time} = parallel_operations(comp, proc)
        after_operations = :erlang.memory()[:total]
        _used_memory = after_operations - before_operations
        Logger.info("compute #{comp} operations with #{proc} processes in #{time} ms")
        # Logger.info("used_memory: #{used_memory}, passed time: #{time} microsecond")
      end
    end
  end



  def parallel_operations(productsnumber, processnumber) do
    # non viene mai usata questa variabile
    # Logger.info("compute #{productsnumber} operations with #{processnumber} processes")
    temp = trunc(productsnumber / processnumber)

    {time, _result} =
      :timer.tc(fn ->
        tasks =
          for _i <- 1..processnumber do
            Task.async(fn -> compute_products(temp) end)
          end

        # Per ogni task aspetta di finire
        for task <- tasks do
          Task.await(task, :infinity)
        end
      end,
      [],
      :millisecond)

    # IO.inspect(time)

    # numero core disponibili per Elixir
    available_scheduler = :erlang.system_info(:logical_processors_available)
    # import CSV
    # file_path = "C:/Users/1dnic/Desktop/Tesi/analisi_elixir/File/datitask.csv"
    # file_path = "/mnt/c/Users/1dnic/Desktop/Tesi/analisi_elixir/File/datitask.csv"
    # file_path = "./File/datitask_nico.csv"

    # data= ["#{System.schedulers_online()};", "#{time};", "#{processnumber};", "#{productsnumber}" , "#{productsnumber*processnumber/time}  \n"]
    scheduler_online = System.schedulers_online()

    # data = [
    #   scheduler_online,
    #   available_scheduler,
    #   time,
    #   processnumber,
    #   productsnumber,
    #   productsnumber * processnumber,
    #   productsnumber * processnumber / (time + 0.0000000000000000000000001),
    #   productsnumber * processnumber / ((time + 0.0000000000000000000000001) * processnumber),
    #   productsnumber * processnumber / ((time + 0.0000000000000000000000001) * scheduler_online),
    #   productsnumber * processnumber / ((time + 0.0000000000000000000000001) * processnumber * scheduler_online)
    # ]

    data = [
      # numero degli scheduler
      "#{scheduler_online},",
      # numero di scheduler disponibili
      "#{available_scheduler},",
      "#{time},",
      "#{processnumber},",
      "#{productsnumber},",
      "#{productsnumber * processnumber},",
      "#{productsnumber * processnumber / (time + 0.0000000000000000000000001)},",
      "#{productsnumber * processnumber / ((time + 0.0000000000000000000000001) * processnumber)},",
      "#{productsnumber * processnumber / ((time + 0.0000000000000000000000001) * scheduler_online)},",
      "#{productsnumber * processnumber / ((time + 0.0000000000000000000000001) * processnumber * scheduler_online)}\n"
    ]

    write(data)
    {:ok,time}

    # write_to_csv(data)
    # write(data, file_path)
  end
end
