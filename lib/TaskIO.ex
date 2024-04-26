defmodule TaskIO do
  # use GenServer
  require Logger

  import MyFile

  def parse_json_file(file_path \\ "./File/read.json") do
    case File.read(file_path) do
      {:ok, json_data} ->
        case Poison.decode(json_data) do
          {:ok, parsed_json} ->
            parsed_json

          {:error, reason} ->
            IO.puts("Failed to parse JSON: #{reason}")
            nil
        end

      {:error, reason} ->
        IO.puts("Failed to read file: #{reason}")
        nil
    end
  end

  def compute_products(0,_) do
    nil
  end

  def compute_products(operations, file) do

      data = parse_json_file()

      # calcolo risoltati del json
      somma = data["somma"] |> Enum.reduce(fn x, acc -> acc + x end)
      sottrazione = data["sottrazione"] |> Enum.reduce(fn x, acc -> acc - x end)
      moltiplicazione = data["moltiplicazione"] |> Enum.reduce(fn x, acc -> acc * x end)
      divisione = data["divisione"] |> Enum.reduce(fn x, acc -> acc / x end)

      # scrittura risultati del json
      result = [
        "#{somma},",
        "#{sottrazione},",
        "#{moltiplicazione},",
        "#{divisione}\n"
      ]

      # write_operations(result)
      IO.write(file, result)

      compute_products(operations - 1, file)
  end

  def run(path_result \\"./File/fileIO.csv") do
    processes = [1, 4, 8, 16, 64, 128, 512]
    productsnumber = 10000
    step = 250

    {:ok, file} = File.open("./File/write.csv", [:write, :append])

    for proc <- processes do
      Logger.info("compute with processes #{proc} and #{System.schedulers()} scheduler")

      for comp <- 500..productsnumber//step do
        {:ok, _time} = parallel_operations(comp, proc, file,path_result)
      end
    end

    File.close(file)
  end

  def parallel_operations(productsnumber, processnumber, file, path_result) do
    # non viene mai usata questa variabile
    # Logger.info("compute #{productsnumber} operations with #{processnumber} processes")

    # divide the products number to assign to each process
    temp = trunc(productsnumber / processnumber)
    # compute the rest to compute to restTask
    rest = rem(productsnumber, processnumber)
    # Logger.info("temp: #{temp} , products_number: #{(temp*processnumber + rest)}")

    # Logger.info("multiple process")
    data = for _i <- 1..40 do
      # {_time, _result} =
        :timer.tc(
          fn ->
            tasks =
              for _i <- 1..processnumber do
                Task.async(fn -> compute_products(temp, file) end)
              end

            restTask = Task.async(fn -> compute_products(rest, file) end)

            # Per ogni task aspetta di finire
            for task <- tasks do
              Task.await(task, :infinity)
            end

            Task.await(restTask, :infinity)
          end,
          [],
          :microsecond
        )
    end

    # calcolo della media dei tempi
    times = data |> Enum.map(fn {time, _result} -> time end)
    total_time = Enum.sum(times)
    average_time = total_time / length(times)


    writeData2File(average_time, processnumber, productsnumber, path_result)
    {:ok, average_time}
  end

  def writeData2File(time, processnumber, productsnumber, path_result) do
    available_scheduler = :erlang.system_info(:logical_processors_available)

    scheduler_online = System.schedulers_online()

    data = [
      "#{scheduler_online},",
      "#{available_scheduler},",
      "#{time},",
      "#{processnumber},",
      "#{productsnumber}\n",
      # "#{time / productsnumber}\n"
    ]

    # scrittura risultato su file
    write(data, path_result)
    # write_to_csv(data)
    {:ok, time}
  end

  def run_more_test(10) do
    nil
  end

  def run_more_test(operations) do
    path =  "./matlab/file_test/n_file_IO3/fileIO" <> Integer.to_string(operations + 1)<> ".csv"
    run(path)
    run_more_test(operations + 1)
  end
end
