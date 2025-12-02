defmodule AdventOne do
  @moduledoc """
  Module to solve the first day's challenge of Advent of Code.
  """

  @doc """
  Reads a list of alphaNumerals from a file and finds the sum of
  the occurence of the number 0

  """

  @dial_size 100
  @starting_position 50

  def solve(file_path) do
    file_path
    |> File.read!()
    |> parse_rotations
    |> follow_rotations()
    |> count_zeros()
  end

  defp parse_rotations(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_rotation/1)
  end

  defp parse_rotation(<<direction, distance::binary>>) do
    {determine_direction(direction), String.to_integer(distance)}
  end

  defp determine_direction(?L), do: :left
  defp determine_direction(?R), do: :right
  defp determine_direction(_), do: :unknown

  defp follow_rotations(rotations) do
    rotations
    |> Enum.scan(@starting_position, &apply_rotation/2)
  end

  defp apply_rotation({:left, distance}, current) do
    Integer.mod(current - distance, @dial_size)
  end

  defp apply_rotation({:right, distance}, current) do
    Integer.mod(current + distance, @dial_size)
  end

  defp count_zeros(positions) do
    Enum.count(positions, &(&1 == 0))
  end
end
