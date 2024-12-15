r = ~r/mul\((\d+),(\d+)\)/
input = File.read!("input")
Regex.scan(r, input, capture: :all_but_first)
|> Enum.map(fn [a, b] -> String.to_integer(a) * String.to_integer(b) end)
|> Enum.sum()
|> IO.inspect(label: :out)
