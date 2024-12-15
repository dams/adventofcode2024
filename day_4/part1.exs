defmodule D4 do
  def get_at(struct, y,x), do: struct |> Map.get(y, %{}) |> Map.get(x, "")

  def get_right(struct, y, x), do: D4.get(struct, [{y, x}, {y, x+1}, {y, x+2}, {y, x+3}])
  def get_down(struct, y, x),  do: D4.get(struct, [{y, x}, {y+1, x}, {y+2, x}, {y+3, x}])

  def get_right_down(struct, y, x), do: D4.get(struct,[{y, x}, {y+1, x+1}, {y+2, x+2}, {y+3, x+3}])
  def get_left_down(struct, y, x),  do: D4.get(struct,[{y, x}, {y+1, x-1}, {y+2, x-2}, {y+3, x-3}])

  def get(struct, list), do: list |> Enum.map(fn {y, x} -> get_at(struct, y, x) end) |> Enum.join() |> D4.check_xmas()

  def check_xmas("XMAS"), do: 1
  def check_xmas("SAMX"), do: 1
  def check_xmas(_), do: 0

end

struct = File.read!("input")
|> String.split("\n")
|> Enum.map(fn s ->
  String.split(s, "", trim: true)
  |> Enum.with_index()
  |> Enum.map(fn {a, b} -> {b, a} end)
  |> Enum.into(%{})
end)
|> Enum.with_index()
|> Enum.map(fn {a, b} -> {b, a} end)
|> Enum.into(%{})


size = length(Map.keys(struct))
Enum.to_list(0..size-1)
|> Enum.map(fn y ->
  Enum.to_list(0..size-1)
  |> Enum.map(fn x ->
    [ D4.get_right(struct, y, x),
      D4.get_down(struct, y, x),
      D4.get_right_down(struct, y, x),
      D4.get_left_down(struct, y, x)
    ] |> Enum.sum()
  end)
  |> Enum.sum()
end)
|> Enum.sum()
|> IO.inspect(label: :out)
