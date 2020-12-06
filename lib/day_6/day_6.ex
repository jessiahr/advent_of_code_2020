defmodule Day6 do
  def input_pattern,
    do: File.read!("lib/day_6/input.txt") |> String.trim() |> String.split("\n\n")

  def part1 do
    input_pattern
    |> get_answers
  end

  def part2 do
    input_pattern
    |> get_answers_v2
  end

  def get_answers(input) do
    input
    |> Enum.map(fn item ->
      String.split(item, "\n")
      |> Enum.join()
      |> String.codepoints()
      |> Enum.uniq()
      |> Enum.count()
    end)
    |> Enum.sum()
  end

  def get_answers_v2(input) do
    input
    |> Enum.map(fn item ->
      String.split(item, "\n")
    end)
    |> Enum.map(fn item ->
      members = Enum.count(item)

      results =
        item
        |> Enum.join()
        |> String.codepoints()
        |> Enum.frequencies()
        |> Enum.filter(fn {k, v} ->
          v == members
        end)
        |> Enum.map(fn {k, v} ->
          k
        end)
    end)
    |> Enum.join()
    |> String.length()
  end
end
