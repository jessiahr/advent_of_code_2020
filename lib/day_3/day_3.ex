defmodule Day3 do
  @moduledoc """
  x = horizontal
  y = vertical going down
  """
  @input_pattern File.read!("lib/day_3/input.txt") |> String.split("\n")
  @input_pattern_width @input_pattern |> List.first() |> String.length()
  @input_pattern_height @input_pattern |> Enum.count()

  @ideal_angles [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
  def sled_that_hill do
    [result] = values_for({0, 0}, @input_pattern_height, [{3, 1}])

    result
  end

  def sled_those_hills do
    Day3.values_for({0, 0}, @input_pattern_height, @ideal_angles)
    |> Enum.reduce(fn count, acc -> count * acc end)
  end

  def check_pos({x, y}) do
    @input_pattern
    |> Enum.at(y)
    |> String.at(rem(x, @input_pattern_width))
  end

  def next_pos({x, y}, {rate_x, rate_y}) do
    {x + rate_x, y + rate_y}
  end

  def count_trees(enum) do
    enum
    |> Stream.filter(fn item ->
      item == "#"
    end)
    |> Enum.count()
  end

  def values_for(start_pos = {_, _}, distance, angles) when is_list(angles) do
    Enum.map(angles, fn angle ->
      Task.async(fn ->
        values_for(start_pos, distance, angle)
        |> count_trees
      end)
    end)
    |> Task.await_many()
  end

  def values_for(start_pos = {_, _}, distance, angle = {_, angle_y}) do
    value = check_pos(start_pos)

    if distance > 1 do
      [value | next_pos(start_pos, angle) |> values_for(distance - angle_y, angle)]
    else
      [value]
    end
  end
end
