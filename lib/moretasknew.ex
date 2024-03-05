### uso Task
defmodule MoreTask1 do
  # @maxTaskCounter  1
  require CSV
  # import CounterServer
  import MyFile

  def operations(productsnumber) do
    for _i <- 1..productsnumber do
      1 * 1000
    end
  end


  def operations2(productsnumber) do
    operations_tail(productsnumber, [])
  end

  defp operations_tail(0, result) do
    # Enum.reverse(result)  # Inverti il risultato in modo che sia nell'ordine corretto
    result
  end

  defp operations_tail(productsnumber, result) do
    new_result = [1 * 1000 | result]
    operations_tail(productsnumber - 1, new_result)
  end

  def run_all_operations() do

    # processes = {1,2}
    processes = {1,2,3,4,5,6,7,8,16,24,32,40,48,120,160,240,280,320,360,400} #20
    # productsnumber = 1001
    productsnumber = 10001
    step = 500

    #productsnumber = 1000
    #processnumber = 1000

    # va da 1 a 1000 in step di 500
    for proc <- 0..(:erlang.tuple_size(processes)-1) do

      for comp <- 1..productsnumber//step do
        # IO.write("executing products: #{comp} processes: #{elem(processes,proc)}....")
        before_operations = :erlang.memory()[:total]
        parallel_operations(comp, elem(processes,proc))
        after_operations = :erlang.memory()[:total]
        used_memory = after_operations - before_operations
        # IO.puts("done after before momory balance #{used_memory/1024} in KB")
      end
    end
    :ok
  end

  # esegue un numero di prodotti in parallelo e aspetta che tutti finiscono
  # scrive il tempo impiegato su file
  def parallel_operations(productsnumber, processnumber) do

    # temp = trunc(productsnumber/processnumber) # non viene mai usata questa variabile

    {time, _result} =
      :timer.tc(fn ->
        tasks =
          for _i <- 1..processnumber do
            Task.async(fn -> operations(productsnumber) end)
          end

        # Per ogni task aspetta di finire
        for task <- tasks do
          Task.await(task, :infinity)
        end
      end)
    IO.inspect(time)

    # numero core disponibili per Elixir
    num_schedulers = :erlang.system_info(:logical_processors_available)
    # import CSV
    # file_path = "C:/Users/1dnic/Desktop/Tesi/analisi_elixir/File/datitask.csv"
    # file_path = "/mnt/c/Users/1dnic/Desktop/Tesi/analisi_elixir/File/datitask.csv"
    file_path = "./File/datitask_nico.csv"

    # data= ["#{System.schedulers_online()};", "#{time};", "#{processnumber};", "#{productsnumber}" , "#{productsnumber*processnumber/time}  \n"]
    numSchedulers = System.schedulers_online()

    data = [
      # numero degli scheduler
      "#{numSchedulers},",
      # numero di scheduler disponibili
      "#{num_schedulers},",
      "#{time},",
      "#{processnumber},",
      "#{productsnumber},",
      "#{productsnumber * processnumber},",
      "#{productsnumber * processnumber / (time + 0.0000000000000000000000001)},",
      "#{productsnumber * processnumber / ((time + 0.0000000000000000000000001) * processnumber)},",
      "#{productsnumber * processnumber / ((time + 0.0000000000000000000000001) * numSchedulers)},",
      "#{productsnumber * processnumber / ((time + 0.0000000000000000000000001) * processnumber * numSchedulers)}\n"
    ]

    write(data, file_path)
  end

  # funzione per il debug credo
  def run_operations() do
    # IO.puts("Enter number of products to make: ")
    productsnumber = IO.gets("") |> String.trim() |> String.to_integer()
    # IO.puts "Inserisci il valore di v: "
    # v = IO.gets("") |> String.trim() |> String.to_integer()
    # IO.puts("Inserisci il numero di processi da avviare: ")
    processnumber = IO.gets("") |> String.trim() |> String.to_integer()

    before_operations = :erlang.memory()[:total]

    parallel_operations(productsnumber, processnumber)

    after_operations = :erlang.memory()[:total]
    _used_memory = after_operations - before_operations

    :ok
  end


end
