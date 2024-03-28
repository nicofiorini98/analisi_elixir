defmodule TaskApplication.Application do
  use Application

  def start(_start_type, _start_args) do
    Observer.start_observer()
    TaskOptimized.run()
    {:ok,self()}
  end

end
