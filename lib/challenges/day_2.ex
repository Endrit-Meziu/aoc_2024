defmodule Challenges.Day2 do

  def solve do
    IO.puts("Enter data (press Enter on an empty line to finish):")

    lines =
      []
      |> read_lines()
      |> parse_lines()

    IO.puts("Part 1 Result: #{compare_lines(lines)}")
    IO.puts("Part 2 Result: #{compare_lines_part2(lines)}")
  end

  defp compare_lines(lines) do
    Enum.reduce(lines, 0, fn line, acc ->
      if safe_line?(line), do: acc + 1, else: acc
    end)
  end

  defp compare_lines_part2(lines) do
    Enum.reduce(lines, 0, fn line, acc ->
      if safe_line?(line) or can_be_safe_with_removal?(line), do: acc + 1, else: acc
    end)
  end

  defp safe_line?([head | tail]) do
    case determine_order(head, tail) do
      :increasing -> valid_line?(head, tail, :increasing)
      :decreasing -> valid_line?(head, tail, :decreasing)
      :invalid -> false
    end
  end

  defp determine_order(head, [next | _]) do
    cond do
      head < next -> :increasing
      head > next -> :decreasing
      true -> :invalid
    end
  end

  defp valid_line?(_, [], _), do: true

  defp valid_line?(current, [next | tail], :increasing) do
    is_increasing(current, next) and valid_line?(next, tail, :increasing)
  end

  defp valid_line?(current, [next | tail], :decreasing) do
    is_decreasing(current, next) and valid_line?(next, tail, :decreasing)
  end

  defp is_increasing(current, next), do: current < next and current + 3 >= next
  defp is_decreasing(current, next), do: current > next and next + 3 >= current

  defp can_be_safe_with_removal?(line) do
    Enum.any?(0..(length(line) - 1), fn index ->
      new_line = List.delete_at(line, index)
      safe_line?(new_line)
    end)
  end

  defp read_lines(lines) do
    input = IO.gets("> ") |> String.trim()

    if input == "" do
      lines
    else
      read_lines([input | lines])
    end
  end

  defp parse_lines(lines) do
    Enum.map(lines, fn line ->
      line
      |> String.split()
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
