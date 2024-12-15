defmodule AoC do

  def is_safe_with_damper?(l) do
    if ( is_safe?(l) ||
      Enum.any?(Enum.to_list(0..length(l)-1), fn i -> 
        {_, l} = List.pop_at(l, i)
        is_safe?(l)
      end)) do
      1
    else
      0
    end
  end

  def is_safe?([h|t]) do
    (increasing?(h, t) || decreasing?(h, t)) && check_adj?(h, t)
  end

  defp increasing?(_e, []), do: true
  defp increasing?(e, [h|_t]) when e >= h, do: false
  defp increasing?(_e, [h|t]), do: increasing?(h, t)

  defp decreasing?(_e, []), do: true
  defp decreasing?(e, [h|_t]) when e <= h, do: false
  defp decreasing?(_e, [h|t]), do: decreasing?(h, t)

  defp check_adj?(_e, []), do: true
  defp check_adj?(e, [h|_t]) when abs(e-h) < 1 or abs(e-h) > 3, do: false
  defp check_adj?(_e, [h|t]), do: check_adj?(h, t)


end

File.read!("input")
|> String.split("\n")
|> Enum.map(fn s -> String.split(s) |> Enum.map(&String.to_integer/1) end)
|> Enum.map(& AoC.is_safe_with_damper?/1)
|> Enum.sum()
|> IO.inspect(label: :out)
