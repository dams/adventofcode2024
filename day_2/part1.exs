defmodule AoC do
  def is_safe?([h|t]) do
    if ( (increasing?(h, t) || decreasing?(h, t)) && check_adj?(h, t)) do
      1
    else
      0
    end
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
|> Enum.map(& AoC.is_safe?/1)
|> Enum.sum()
|> IO.inspect(label: :out)
