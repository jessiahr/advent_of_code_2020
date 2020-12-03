defmodule Day3Test do
  use ExUnit.Case

  test "gets a value at a position" do
    assert Day3.check_pos({0, 0}) == "."
    assert Day3.check_pos({0, 30}) == "."
    assert Day3.check_pos({0, 31}) == "#"
    assert Day3.check_pos({30, 0}) == "."
  end

  test "gets next position based on a coord" do
    assert Day3.next_pos({0, 0}, {3, 1}) == {3, 1}
  end

  test "gets values for a vector" do
    assert Day3.values_for({0, 0}, 5, {3, 1}) == [".", ".", "#", "#", "#"]
  end

  test "gets value for position outside initial tile" do
    assert Day3.check_pos({31, 0}) == "."
  end

  test "gets full vector from {0,0}" do
    result = Day3.sled_that_hill()
    assert result == 187
  end

  test "checks distance with angle {1, 1}" do
    result = Day3.values_for({0, 0}, 11, [{1, 1}])
    assert result == [6]
  end

  test "checks many angles before sledding" do
    assert Day3.sled_those_hills() == 4_723_283_400
  end
end
