defmodule MoreTask1 do
#@maxTaskCounter  0
#
# def addTo(input), do: input+@maxTaskCounter
  #end
#  @taskCounter  0
#@tasks
  def operations(u, v) do

    for _i<-1..v
    do
      for _j<-1..u
      do
        2*3
      end
    end

  end


  def parallel_operations(u,v,process)
  do
    taskCnt = 0
    maxTaskCnt = 0
    #MoreTask1.addTo(1)
   # @tasks=[]
   #taskCounter=0
   #maxTaskCounter=0
  # @maxTaskCounter= 10
   # MyObserver.count_processes_per_core()
   #IO.puts @maxTaskCounter
    for _i<- 1..process

    do
      #MyObserver.count_processes_per_core()
      Task.async(fn->
                       # @taskCounter=@taskCounter+1
                        #if(@maxTaskCounter<@taskCounter) do @maxTaskCounter=@taskCounter end
                        IO.puts("Number of parallel tasks: #{taskCnt}")
                        taskCnt++
                        operations(u,v)
                        #taskCnt--
                        #@taskCounter=@taskCounter-1
                        #IO.puts("Number of parallel tasks: #{maxTaskCounter}")
                      end) #|> Task.await()
          # @tasks =  @tasks ++ [currTask]
          #@tasks = [@tasks | currTask]
      #IO.puts currTask[:pid]
    end


    #IO.puts @tasks
    #Task.await(tasks)
    # ottieni il numero di scheduler disponibili
num_schedulers = :erlang.system_info(:logical_processors_available) #numero core disponibili per Elixir
#IO.puts("Number of parallel tasks: #{@maxTaskCounter}")
task_per_cores = process/num_schedulers
IO.puts("Stima numero di tasks/core : #{task_per_cores}")

      #aspetto che tutti i tasks siano completati per stampare il risultato del tempo impiegato
      #for task<- @tasks
       # do
        #  Task.await(task)
      #end

   #end

   end



  def monitoring()
  do


       # schedulers = :erlang.system_info(:schedulers_online)
    #IO.puts("Numero di schedulers online: #{schedulers}")
    #counters = :erlang.system_info(:schedulers, :counters)
    #IO.inspect(counters)
    # ottenere tutti i processi
    #processes = :erlang.processes()

    # loop attraverso tutti i processi
    #Enum.each(processes, fn(pid) ->
      # ottenere le informazioni sul processo
     # info = Process.info(pid)

  end

  def run_operations()
  do


    IO.puts "Inserisci il valore di u: "
    u = IO.gets("") |> String.trim() |> String.to_integer()
    IO.puts "Inserisci il valore di v: "
    v = IO.gets("") |> String.trim() |> String.to_integer()
    IO.puts "Inserisci il numero di processi da avviare: "
    process = IO.gets("") |> String.trim() |> String.to_integer()

    before_operations = :erlang.memory()[:total]



    {time,_result}=:timer.tc(fn->parallel_operations(u,v,process) end)
    #:recon.trace([:all], trace_event: :process_info, print: :true)
    #:recon_trace.calls(MyModule, :all, print: :true)
   after_operations = :erlang.memory()[:total]
   used_memory = after_operations - before_operations
  # node_name= Node.self()
   #IO.puts("Dati da #{node_name}")
   IO.puts("La funzione ha usato #{used_memory} byte di memoria")
   IO.puts("Tempo impiegato: #{time} microsecondi")

  end
end
