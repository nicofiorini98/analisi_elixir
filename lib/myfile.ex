defmodule MyFile do

  require CSV

  def write_to_csv(data) do

    file_path = "./File/test.csv"

    {:ok, file} = File.open(file_path, [:write,:utf8])
    head = [
      "N_Scheduler",
      "N_Available_Sched",
      "Time",
      "N_processes",
      "N_products",
      "N_processes * N_products",
      "N_products * N_process / time",
      "N_products * N_processes / (time * n_process)",
      "N_products * N_process / (time * N_Schedulers)",
      "N_products * N_processes / (time * N_processes * N_Schedulers)"
    ]

    #concatenation header csv with the data
    data = [head |[data]]

    data
    |> CSV.encode
    |> Enum.each(&IO.write(file,&1))

    File.close(file)
  end

  def write(data,file_path \\ "./File/test.csv") do
    {:ok, file} = File.open(file_path, [:write, :append])
    IO.write(file, data)
    File.close(file)
  end

  #only for debug
  def test_csv do
    data = [
      ["Name", "Age", "Country"],
      ["Alice", 30, "USA"],
      ["Bob", 25, "Canada"],
      ["Charlie", 35, "UK"]
    ]
    write_to_csv(data)
  end

end
