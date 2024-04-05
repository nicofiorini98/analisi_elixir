defmodule ConcurrentTask do
  # use GenServer
  require Logger
  import MyFile


  def compute_products(productsnumber) do
    for _i <- 1..productsnumber do
      1 * 1000
    end
  end


  def run do
    processes = [1, 2, 3, 4, 5, 6, 7, 8, 16, 32, 64, 128, 256]
    productsnumber = 100_000
    step = 500

    for proc <- processes do
      Logger.info("compute with processes #{proc} and #{System.schedulers} scheduler")
      for comp <- 500..productsnumber//step do
        # before_operations = :erlang.memory()[:total]
        {:ok, _time} = parallel_operations(comp, proc)
        # after_operations = :erlang.memory()[:total]
        # _used_memory = after_operations - before_operations

        # Logger.info("compute #{comp} operations with #{proc} processes in #{time}")
        # temp = trunc(comp/proc)
        # Logger.info("compute #{comp} operations with #{proc} processes in #{time} us, computation per process #{temp}")
        # Logger.info("used_memory: #{used_memory}, passed time: #{time} microsecond")
      end
    end
    nil
  end

  def parallel_operations(productsnumber, processnumber) do
    # non viene mai usata questa variabile
    # Logger.info("compute #{productsnumber} operations with #{processnumber} processes")

    # if productsnumber >= processnumber and processnumber != 1 do
      #divide the products number to assign to each process
      temp = trunc(productsnumber / processnumber)
      # compute the rest to compute to restTask
      rest = rem(productsnumber , processnumber)

      {time, _result} =
        :timer.tc(
          fn ->
            tasks =
              for _i <- 1..processnumber do
                Task.async(fn -> compute_products(temp) end)
              end
            restTask = Task.async(fn -> compute_products(rest) end)

            # Aspetta di finire ogni task per ottenere i risultati
            for task <- tasks do
              Task.await(task, :infinity)
            end
            Task.await(restTask, :infinity)
          end,
          [],
          :microsecond
        )
        writeData2File(time,processnumber,productsnumber)
        {:ok,time}
    # end
    # else
    #   {time, _result} =
    #     :timer.tc(
    #       fn ->
    #         task = Task.async(fn -> compute_products(productsnumber) end)
    #         Task.await(task, :infinity)
    #         # Logger.info("single products")
    #       end,
    #       [],
    #       :microsecond
    #     )
    #   writeData2File(time,processnumber,productsnumber)
    #   {:ok, time}
    # end
  end

  def writeData2File(time,processnumber,productsnumber) do
    available_scheduler = :erlang.system_info(:logical_processors_available)

    # scheduler_online = System.schedulers_online()
    scheduler = System.schedulers()

    data = [
      "#{scheduler},",
      "#{available_scheduler},",
      "#{time},",
      "#{processnumber},",
      "#{productsnumber},",
      "#{time/productsnumber}\n"
    ]

    # scrittura risultato su file
    write(data)
    # write_to_csv(data)
    {:ok, time}
  end
end
