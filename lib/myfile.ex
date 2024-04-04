defmodule MyFile do


  def new_file() do
    file_path = "./File/test.csv"

    header = ["N_Scheduler,N_Available_Scheduler,Time,N_processes,N_products\n"]

    {:ok, file} = File.open(file_path, [:write])
    IO.write(file, header)

    File.close(file)
  end

  @spec write(any()) :: :ok | {:error, atom()}
  def write(data,file_path \\ "./File/test.csv") do
    {:ok, file} = File.open(file_path, [:write,:append])
    IO.write(file, data)
    File.close(file)
  end

  def write_operations(data,file_path \\ "./File/write.csv") do
    {:ok, file} = File.open(file_path, [:write,:append])
    IO.write(file, data)
    File.close(file)
  end


  #only for debug
  end
