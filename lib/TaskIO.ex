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

  def compute_products(0, _file) do
    nil
  end

  def compute_products(operations, file) do
    data = parse_json_file()

    # calcolo risultati del json
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

    IO.write(file, result)
    # chiamata ricorsiva
    compute_products(operations - 1, file)
  end

  def run do
    # processes = [1, 2, 3, 4, 5, 6, 7, 8, 16, 32, 64, 128, 256, 512,3000]
    processes = [3000]
    operationsnumber = 20_000
    step = 250

    {:ok, file} = File.open("./File/write.csv", [:write, :append])

    for proc <- processes do
      Logger.info("compute with processes #{proc} and #{System.schedulers()} scheduler")

      for comp <- 500..operationsnumber//step do
        {:ok, _time} = parallel_operations(comp, proc, file)
      end
    end

    File.close(file)
  end

  def parallel_operations(operationsnumber, processnumber, file) do
    # divide the products number to assign to each process
    temp = trunc(operationsnumber / processnumber)
    # compute the rest to compute to restTask
    rest = rem(operationsnumber, processnumber)
    # Logger.info("temp: #{temp} , products_number: #{(temp*processnumber + rest)}")

    # Logger.info("multiple process")
    {time, _result} =
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

    writeData2File(time, processnumber, operationsnumber)
    {:ok, time}
  end

  def writeData2File(time, processnumber, productsnumber) do
    available_scheduler = :erlang.system_info(:logical_processors_available)

    scheduler_online = System.schedulers()

    data = [
      "#{scheduler_online},",
      "#{available_scheduler},",
      "#{time},",
      "#{processnumber},",
      "#{productsnumber},",
      "#{time / productsnumber}\n"
    ]

    # scrittura risultato su file
    write(data, "./File/testIO.csv")
    # write_to_csv(data)
    {:ok, time}
  end
end
