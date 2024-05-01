defmodule ConcurrentTask do
  # use GenServer
  require Logger
  import MyFile


  # Function to test in a distributed way
  def compute_products(productsnumber) do
    for _i <- 1..productsnumber do
      1 * 1000
    end
  end


  # Function that run multiple parallel_operations to test
  def run(path \\ './File/concurrent_test.csv') do
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

  # Function that test compute_products distribuing
  # multiple products in multiple process
  # The time spent is written in a csv file
  def parallel_operations(productsnumber, processnumber, path) do

      #divide the products number to assign to each process
      temp = trunc(productsnumber / processnumber)

      # compute the rest to compute to restTask
      rest = rem(productsnumber , processnumber)

      # execute multiple products in asyncronous way
      # and wait for the result. :timer.tc/3 return time and
      # result of the function passed
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

        # function that write the result in csv
        writeData2File(time,processnumber,productsnumber,path)
        {:ok,time}
  end


  #This function write the data needed in a csv file to analyze in matlab
  def writeData2File(time,processnumber,productsnumber,path) do

    # scheduler disponibili di default uguali ai core logici
    available_scheduler = :erlang.system_info(:logical_processors_available)

    # Scheduler utilizzati dal sistema
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




  # base case, do nothing when num_of_test reach 20
  def run_more_test(20) do
    nil
  end

  # this is an auxiliary function that run multiple test and create multiple file
  # it was done to average over multiple samples
  # run with 0
  def run_more_test(num_of_test) do
    path =  "./matlab/file_test/n_file2/file" <> Integer.to_string(num_of_test + 1)<> ".csv"
    run(path)
    run_more_test(num_of_test + 1)
  end


end
