defmodule Challenges.Day3 do

  @basic_input_filter_regex ~r/mul\(([0-9]{1,3}),([0-9]{1,3})\)/
  @input_filter_regex ~r/(mul\(([0-9]{1,3}),([a-zA-Z0-9]{1,3})\)|do\(\)|don't\(\))/
  def solve do
    IO.puts("Enter input:")

    input = read_input()

    part_one = input
    |> filter_input_string
    |> solve_part_one

    IO.puts("First part result: #{part_one}")

    {part_two, _} = input
    |> filter_input_string_additional()
    |> solve_part_two()

    IO.puts("Second part result: #{part_two}")
  end

  defp filter_input_string(input) do
    @basic_input_filter_regex
    |> Regex.scan(input)
  end

  defp filter_input_string_additional(input) do
    @input_filter_regex
    |> Regex.scan(input)
  end

  defp solve_part_two(filter_input_array) do
    Enum.reduce(filter_input_array, {0, false},  fn array, {acc, skip_multiplication} ->
      cond do
        length(array) == 2 ->
          if Enum.any?(array, fn name -> String.contains?(name, "do()") end) do
            {acc, false}
          else
            {acc, true}
          end
        true ->
            [_, _, x, y] = array
            if skip_multiplication do
              {acc, skip_multiplication}
            else
              acc = acc + (String.to_integer(x) * String.to_integer(y))
              {acc, skip_multiplication}
            end
          end
    end)
  end

  defp solve_part_one(filtered_input_array) do
    Enum.map(filtered_input_array, fn [_, x, y] ->
      String.to_integer(x) * String.to_integer(y)
    end)
    |> Enum.sum
  end

  defp read_input, do: IO.gets(">") |> String.trim

end
