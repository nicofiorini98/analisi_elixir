defmodule ConcurrentTask do
  # use GenServer
  require Logger
  import MyFile


  def compute_products(productsnumber) do
    for _i <- 1..productsnumber do
      1 * 1000
    end
  end


  def run(path) do
    processes = [1, 2, 3, 4, 5, 6, 7, 8, 16, 32, 64, 128, 256,512]
    productsnumber = 100_000
    step = 500

    for proc <- processes do
      Logger.info("compute with processes #{proc} and #{System.schedulers} scheduler")
      for comp <- 500..productsnumber//step do
        {:ok, _time} = parallel_operations(comp, proc,path)
      end
    end
    nil
  end

  def parallel_operations(productsnumber, processnumber, path) do

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
        writeData2File(time,processnumber,productsnumber,path)
        {:ok,time}
  end

  def writeData2File(time,processnumber,productsnumber,path) do
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
    write(data,path)
    # write_to_csv(data)
    {:ok, time}
  end
  def run_more_test(20) do
    nil
  end

  def run_more_test(operations \\0) do
    path =  "./matlab/file_test/n_file2/fileIO" <> Integer.to_string(operations + 1)<> ".csv"
    run(path)
    run_more_test(operations + 1)
  end

end
