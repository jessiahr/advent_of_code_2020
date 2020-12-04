defmodule Day4 do
  defmodule Passport do
    @valid_chars ~w(a b c d e f 1 2 3 4 5 6 7 8 9 0)
    defstruct [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid]

    def valid?(%Passport{
          byr: byr,
          iyr: iyr,
          eyr: eyr,
          hgt: hgt,
          hcl: hcl,
          ecl: ecl,
          pid: pid,
          cid: cid
        })
        when nil in [byr, iyr, eyr, hgt, hcl, ecl, pid] do
      false
    end

    def valid?(pp) do
      pp
      |> Map.from_struct()
      |> Enum.map(&validate_field/1)
      |> Enum.all?()
    end

    def validate_field({:byr, v}) do
      {v, _} = Integer.parse(v)

      1920 <= v and v <= 2002
    end

    def validate_field({:iyr, v}) do
      {v, _} = Integer.parse(v)

      2010 <= v and v <= 2020
    end

    def validate_field({:eyr, v}) do
      {v, _} = Integer.parse(v)

      2020 <= v and v <= 2030
    end

    def validate_field({:hgt, v}) do
      String.slice(v, -2..-1)
      |> case do
        "cm" ->
          h =
            String.split(v, "cm")
            |> List.first()
            |> Integer.parse()
            |> elem(0)

          150 <= h and h <= 193

        "in" ->
          h =
            String.split(v, "in")
            |> List.first()
            |> Integer.parse()
            |> elem(0)

          59 <= h and h <= 76

        _ ->
          false
      end
    end

    def validate_field({:hcl, v}) when is_binary(v) do
      with ["", color] <- String.split(v, "#"),
           6 <- String.length(color) do
        color_space =
          String.codepoints(color)
          |> Enum.uniq()

        color_space -- @valid_chars == []
      else
        _ -> false
      end
    end

    def validate_field({:ecl, v}) when is_binary(v) and v in ~w(amb blu brn gry grn hzl oth) do
      true
    end

    def validate_field({:pid, v}) do
      with 9 <- String.length(v),
           pid <- v |> String.codepoints() |> Enum.uniq() do
        pid -- ~w(0 1 2 3 4 5 6 7 8 9) == []
      else
        _ ->
          false
      end
    end

    def validate_field({:cid, v}), do: true

    def validate_field(_), do: false
  end

  @input_pattern File.read!("lib/day_4/input.txt") |> String.split("\n\n")
  def process_batch(batch \\ nil) do
    (batch || @input_pattern)
    |> list_passports
    |> filter_valid
  end

  def list_passports(input) do
    input
    |> Enum.map(&parse_block/1)
  end

  def filter_valid(passports) when is_list(passports) do
    passports
    |> Enum.filter(fn pp -> Passport.valid?(pp) end)
  end

  def parse_block(block) do
    params =
      block
      |> String.split([" ", "\n"])
      |> Enum.map(fn key_pair ->
        [key, value] = String.split(key_pair, ":")
        {String.to_atom(key), value}
      end)
      |> Enum.into(%{})

    struct(Passport, params)
  end
end
