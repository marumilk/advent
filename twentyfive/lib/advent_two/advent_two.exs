defmodule AdventTwo do
  @moduledoc """
    Module to solve the second day's challenge of Advent of Code.
    """

    @doc """
    find all numbers within given ranges that have an repeated digits
    then sum those numbers.
    Repeated digits are defined by having at least two consecutive sequences of the same digits.
    """

    def solve(input) do
      input
      |> parse_ranges()
      |> Enum.flat_map(&repeated_numbers_in_range/1)
      |> Enum.sum()
    end

    defp parse_ranges(input) do
      input
      |> String.trim()
      |> String.split(",", trim: true)
      |> Enum.map(fn range_str ->
        [start, stop] = String.split(range_str, "-")
        String.to_integer(start)..String.to_integer(stop)
      end)
    end

    defp repeated_numbers_in_range(range) do
      range.first
      |> digit_count()
      |> Range.new(digit_count(range.last))
      |> Enum.flat_map(&all_repeated_with_digits/1)
      |> Enum.uniq()
      |> Enum.filter(&(&1 in range))
    end

    defp all_repeated_with_digits(1), do: []

    defp all_repeated_with_digits(digits) do
      for pattern_len <- 1..div(digits, 2),
      rem(digits, pattern_len) == 0,
      pattern <- pattern_range(pattern_len) do
        pattern
        |> Integer.to_string()
        |> String.duplicate(div(digits, pattern_len))
        |> String.to_integer()
      end
    end

    defp pattern_range(1), do: 1..9
    defp pattern_range(len), do: Integer.pow(10, len - 1)..(Integer.pow(10, len) - 1)

    defp digit_count(n), do: n |> Integer.to_string() |> String.length()
end
