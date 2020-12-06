defmodule Day6Test do
  use ExUnit.Case

  test "gets answers for group " do
    assert Day6.get_answers(
             """
             abc

             a
             b
             c

             ab
             ac

             a
             a
             a
             a

             b
             """
             |> String.split("\n\n")
           ) == 11
  end

  test "part 1 " do
    assert Day6.part1() == 6532
  end

  test "gets answers v2 for group " do
    assert Day6.get_answers_v2(
             """
             abc

             a
             b
             c

             ab
             ac

             a
             a
             a
             a

             b
             """
             |> String.trim()
             |> String.split("\n\n")
           ) == 6
  end

  test "part 2 " do
    assert Day6.part2() == 3427
  end
end
