defmodule Day2Test do
  use ExUnit.Case

  test "it checks password" do
    assert Day2.check_pass("1-3 a: abcde") == true
    assert Day2.check_pass("1-3 b: cdefg") == false
    assert Day2.check_pass("2-9 c: ccccccccc") == true
  end

  test "it checks password list" do
    assert Day2.part1() == 603
  end

  test "it checks a v2 pass" do
    assert Day2.check_pass_v2("1-3 a: abcde") == true
  end

  test "it checks password v2 list" do
    assert Day2.part2() == 404
  end
end
