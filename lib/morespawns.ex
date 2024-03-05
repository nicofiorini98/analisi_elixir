defmodule MoreSpawns do
  import MyFile


  def run_all_operations() do

    # processes = {1,2}
    processes = {1,2,3,4,5,6,7,8,16,24,32,40,48,120,160,240,280,320,360,400}
    # productsnumber = 1001
    productsnumber = 10001
    step = 500

    #productsnumber = 1000
    #processnumber = 1000

    # va da 1 a 1000 in step di 500
    for proc <- 0..(:erlang.tuple_size(processes)-1) do

      for comp <- 1..productsnumber//step do
        IO.write("executing products: #{comp} processes: #{elem(processes,proc)}....")
        before_operations = :erlang.memory()[:total]
        parallel_operations(comp, elem(processes,proc))
        after_operations = :erlang.memory()[:total]
        used_memory = after_operations - before_operations
        IO.puts("done after before momory balance #{used_memory}")
      end
    end
    :ok
  end

  def operations(productsnumber) do
    for _i <- 1..productsnumber do
      a = 2 * 1000
      b = 2 * 1000
      a * b
    end
  end

  def parallel_operations(productsnumber, processnumber) do

    # Perchè qui usa temp??
    temp = trunc(productsnumber / processnumber)

    {time, _result} =
      :timer.tc(fn ->
        pids =
          for _i <- 1..processnumber do
            parent = self()

            spawn_link(fn -> operations(productsnumber)
            send(parent, :done) end)
          end

        Enum.each(pids, fn _pid ->
          receive do
            :done ->
              true
          end
        end)
      end)


    # numero core disponibili per Elixir
    num_schedulers = :erlang.system_info(:logical_processors_available)
    # IO.puts("Number of parallel tasks: #{get_count(pid)}")
    task_per_cores = processnumber / num_schedulers
    IO.puts("Stima numero di tasks/core : #{task_per_cores}")
    IO.puts("Tempo impiegato: #{time} microsecondi")
    file_path = "./File/datispawn_nico.csv"

    data = [
      "#{System.schedulers_online()},",
      "#{time},",
      "#{processnumber},",
      "#{productsnumber}\n"
    ]

    write(data, file_path)
  end

end
