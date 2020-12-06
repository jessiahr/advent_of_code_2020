defmodule Day2 do
  def input_pattern, do: File.read!("lib/day_2/input.txt") |> String.split("\n")

  def part1 do
    input_pattern
    |> Enum.filter(&check_pass/1)
    |> Enum.count()
  end

  def part2 do
    input_pattern
    |> Enum.filter(&check_pass_v2/1)
    |> Enum.count()
  end

  def check_pass_v2(slug) do
    try do
      [rule, pass] =
        slug
        |> String.split(":", trim: true)

      [rule_range, rule_char] = String.split(rule)

      [rule_range_min, rule_range_max] =
        rule_range |> String.split("-") |> Enum.map(&String.to_integer/1)

      keys = [
        pass |> String.trim() |> String.at(rule_range_min - 1),
        pass |> String.trim() |> String.at(rule_range_max - 1)
      ]

      keys |> Enum.uniq() |> Enum.count() == 2 and keys |> Enum.member?(rule_char)
    rescue
      e in MatchError -> false
    end
  end

  def check_pass(slug) do
    try do
      [rule, pass] =
        slug
        |> String.split(":")

      [rule_range, rule_char] = String.split(rule)

      [rule_range_min, rule_range_max] =
        rule_range |> String.split("-") |> Enum.map(&String.to_integer/1)

      parts =
        pass
        |> String.codepoints()
        |> Enum.frequencies()

      Map.get(parts, rule_char) >= rule_range_min and Map.get(parts, rule_char) <= rule_range_max
    rescue
      e in MatchError -> false
    end
  end
end
