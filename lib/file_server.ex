defmodule FileServer do
  use GenServer

  # Funzione di inizializzazione
  def start_link(file_path \\"./File/write.csv") do
    GenServer.start_link(__MODULE__, file_path, [])
  end

  # Gestione degli eventi
  def init(file_path) do
    {:ok, file_path}
  end

  # Funzione per aprire il file
  def handle_call({:open_file}, _from, file_path) do
    {:ok, file} = File.open(file_path, [:append])
    {:reply, {:ok, file}, file_path}
  end

  # Funzione per scrivere sul file
  def handle_cast({:write_to_file, data}, file) do
    # IO.binwrite(file, data)
    IO.inspect(file)
    IO.write(file,data)
    {:noreply, file}
  end

  # Funzione per chiudere il file
  def handle_call({:close_file}, _from, file) do
    File.close(file)
    {:stop, :normal, file}
  end

  def write(data,file_path \\ "./File/test.csv") do
    {:ok, file} = File.open(file_path, [:write,:append])
    IO.write(file, data)
    File.close(file)
  end

end
