{l1, l2} = File.read!("input")
|> String.split("\n")
|> Enum.map(fn s -> String.split(s)
                 |> Enum.map(&String.to_integer/1)
                 |> List.to_tuple()
end)
|> Enum.unzip()

h = l2
|> Enum.reduce(%{}, fn e, acc -> Map.update(acc, e, 1, & &1 + 1) end)

l1
|> Enum.reduce(0, & &1 * Map.get(h, &1, 0) + &2)
|> IO.inspect(label: :out)
