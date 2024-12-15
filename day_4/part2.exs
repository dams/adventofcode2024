defmodule D4 do
  def get_at(struct, y,x), do: struct |> Map.get(y, %{}) |> Map.get(x, "")

  def get_right_down(struct, y, x), do: D4.get(struct,[{y, x}, {y+1, x+1}, {y+2, x+2}])
  def get_left_down(struct, y, x),  do: D4.get(struct,[{y, x+2}, {y+1, x+1}, {y+2, x}])

  def get(struct, list), do: list |> Enum.map(fn {y, x} -> get_at(struct, y, x) end) |> Enum.join() |> D4.check_xmas()

  def check_xmas("MAS"), do: 1
  def check_xmas("SAM"), do: 1
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
    if (D4.get_right_down(struct, y, x) + D4.get_left_down(struct, y, x) == 2) do
      1
    else
      0
    end
  end)
  |> Enum.sum()
end)
|> Enum.sum()
|> IO.inspect(label: :out)
