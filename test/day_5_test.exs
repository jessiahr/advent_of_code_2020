defmodule Day5Test do
  use ExUnit.Case

  test "gets row " do
    assert Day5.get_row("FBFBBFF") == 44
  end

  test "gets seat" do
    assert Day5.get_seat("RLR") == 5
  end

  test "gets seat id " do
    assert Day5.get_seat_id("FBFBBFFRLR") == 357
  end

  test "gets my seat" do
    assert Day5.get_my_seat() == [682]
  end
end
