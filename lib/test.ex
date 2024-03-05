defmodule Test do
  def operations(productsnumber) do
    for _i <- 1..productsnumber do
      2 * 1000
    end
  end

  def run do
    {time, _result} =
      :timer.tc(fn ->
        tasks =
          for _i <- 1..400 do
            Task.async(fn ->
              operations(100)
            end)
          end

        # Per ogni task aspetta di finire
        for task <- tasks do
          Task.await(task, :infinity)
        end
      end)
  end
end
