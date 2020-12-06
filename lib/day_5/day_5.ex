defmodule Day5 do
  @input_pattern File.read!("lib/day_5/input.txt") |> String.split("\n")

  def get_seat(seat) when is_binary(seat) do
    seat
    |> String.replace("L", "F")
    |> String.replace("R", "B")
    |> String.codepoints()
    |> apply_partition({0, 7})
  end

  def get_row(seat) when is_binary(seat) do
    seat
    |> String.codepoints()
    |> apply_partition({0, 127})
  end

  def get_seat_id(path) do
    {row, seat} =
      path
      |> String.codepoints()
      |> Enum.split(-3)

    get_seat("#{seat}") + 8 * get_row("#{row}")
  end

  def get_my_seat do
    seats = get_all_seat_ids
    lowest = seats |> List.first()
    highest = seats |> List.last()

    (lowest..highest |> Enum.into([])) -- seats
  end

  def get_all_seat_ids do
    @input_pattern
    |> Enum.map(&get_seat_id/1)
    |> Enum.sort()
  end

  def apply_partition([], {selected_row, selected_row}), do: selected_row

  def apply_partition([head | seat_path], {front_most, back_most}) do
    total_rows = back_most..front_most |> Enum.count()
    new_partition_size = div(total_rows, 2)

    selected_rows =
      case head do
        "F" ->
          {front_most, back_most - new_partition_size}

        "B" ->
          {front_most + new_partition_size, back_most}
      end

    apply_partition(seat_path, selected_rows)
  end
end
