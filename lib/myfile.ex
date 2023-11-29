defmodule MyFile do

  def write(data,file_path)
  do

    {:ok, file} = File.open(file_path, [:write, :append])
    IO.write(file, data)
    File.close(file)
  end


end
