defmodule Challenges.Day1 do

  def solve do
    IO.puts("Enter data (press Enter on an empty line to finish):")

    {list1, list2} =
      []
      |> read_lines
      |> parse_lines

    list1 = Enum.sort(list1)
    list2 = Enum.sort(list2)

    calculate_frequencies_result(list1, list2)
  end

  defp read_lines(lines) do
    input = IO.gets("> ")
    input = String.trim(input)

    if input == "" do
      lines
    else
      read_lines([input | lines])
    end
  end

  defp parse_lines(lines) do
    Enum.reduce(lines, {[],[]}, fn line, {list1, list2} ->
      [num1_str, num2_str] = String.split(line, ~r/\s+/)
      num1 = String.to_integer(num1_str)
      num2 = String.to_integer(num2_str)
      { [num1 | list1], [num2 | list2] }
    end)
  end

  #Part 1
  defp calculate_distance(list1, list2) do
    Enum.zip(list1, list2)
    |> Enum.map(fn {num1, num2} -> abs(num1 - num2) end)
    |> Enum.sum()
  end

  #Part 2
  defp calculate_frequencies_result(list1, list2) do
    l2_freq = Enum.frequencies(list2)
    Enum.map(list1, fn list1_item -> list1_item * Map.get(l2_freq, list1_item, 0) end)
    |> Enum.sum()
  end
end
