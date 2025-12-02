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
      |> Enum.flat_map(&expand_range/1)
      |> Enum.filter(&repeated?/1)
      |> Enum.sum()
    end

    defp parse_ranges(input) do
      input
      |> String.trim()
      |> String.split(",", trim: true)
      |> Enum.map(&parse_range/1)
    end

    defp parse_range(range_str) do
      [start, stop] = String.split(range_str, "-")
      {String.to_integer(start), String.to_integer(stop)}
    end

    defp expand_range({start, stop}) do
      start..stop |> Enum.to_list()
    end

    defp repeated?(n) do
      s = Integer.to_string(n)
      len = String.length(s)
      half = div(len, 2)

      rem(len, 2) == 0 and
        String.slice(s, 0, half) == String.slice(s, half, half)
    end
end
