defmodule TimeFrame do
  @moduledoc """
  https://medium.com/elixirlabs/implement-a-basic-block-yield-with-elixir-d00f313831f7
  """
  defmacro execute(name, units \\ :microsecond, do: yield) do
    quote do
      start = System.monotonic_time(unquote(units))
      result = unquote(yield)
      time_spent = System.monotonic_time(unquote(units)) - start
      IO.puts("Executed #{unquote(name)} in #{time_spent} #{unquote(units)}")
      result
    end
  end
end
