defmodule Observer do
  def start_observer do
    Task.async(fn ->
      Mix.ensure_application!(:wx)
      Mix.ensure_application!(:runtime_tools)
      Mix.ensure_application!(:observer)
      :observer.start()
    end
    )
  end
end
