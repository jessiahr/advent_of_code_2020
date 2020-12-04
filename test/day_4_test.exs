defmodule Day4Test do
  use ExUnit.Case

  test "it parses a valid block" do
    assert Day4.parse_block(
             "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd\nbyr:1937 iyr:2017 cid:147 hgt:183cm"
           ) == %Day4.Passport{
             byr: "1937",
             cid: "147",
             ecl: "gry",
             eyr: "2020",
             hcl: "#fffffd",
             hgt: "183cm",
             iyr: "2017",
             pid: "860033327"
           }
  end

  test "for the example passports it counts the valid ones" do
    input = [
      %Day4.Passport{
        byr: "1937",
        cid: "147",
        ecl: "gry",
        eyr: "2020",
        hcl: "#fffffd",
        hgt: "183cm",
        iyr: "2017",
        pid: "860033327"
      },
      %Day4.Passport{
        byr: "1929",
        cid: "350",
        ecl: "amb",
        eyr: "2023",
        hcl: "#cfa07d",
        hgt: nil,
        iyr: "2013",
        pid: "028048884"
      },
      %Day4.Passport{
        byr: "1931",
        cid: nil,
        ecl: "brn",
        eyr: "2024",
        hcl: "#ae17e1",
        hgt: "179cm",
        iyr: "2013",
        pid: "760753108"
      },
      %Day4.Passport{
        byr: nil,
        cid: nil,
        ecl: "brn",
        eyr: "2025",
        hcl: "#cfa07d",
        hgt: "59in",
        iyr: "2011",
        pid: "166559648"
      }
    ]

    assert Day4.filter_valid(input) |> Enum.count() == 2
  end

  test "for the input passports it counts the valid ones" do
    assert Day4.process_batch() |> Enum.count() == 172
  end

  test "byr validates" do
    assert Day4.Passport.validate_field({:byr, "2002"}) == true
    assert Day4.Passport.validate_field({:byr, "2003"}) == false
  end

  test "hgt validates" do
    assert Day4.Passport.validate_field({:hgt, "60in"}) == true
    assert Day4.Passport.validate_field({:hgt, "190cm"}) == true
    assert Day4.Passport.validate_field({:hgt, "190in"}) == false
    assert Day4.Passport.validate_field({:hgt, "190"}) == false
  end

  test "hcl validates" do
    assert Day4.Passport.validate_field({:hcl, "#123abc"}) == true
    assert Day4.Passport.validate_field({:hcl, "#123abz"}) == false
  end

  test "ecl validates" do
    assert Day4.Passport.validate_field({:ecl, "brn"}) == true
    assert Day4.Passport.validate_field({:ecl, "wat"}) == false
  end

  test "pid validates" do
    assert Day4.Passport.validate_field({:pid, "000000001"}) == true
    assert Day4.Passport.validate_field({:pid, "0123456789"}) == false
  end

  test "eyr validates" do
    assert Day4.Passport.validate_field({:eyr, "2020"}) == true
    assert Day4.Passport.validate_field({:eyr, "2030"}) == true

    assert Day4.Passport.validate_field({:eyr, "2019"}) == false
    assert Day4.Passport.validate_field({:eyr, "2031"}) == false

    assert %Day4.Passport{
             byr: "1926",
             cid: "100",
             ecl: "amb",
             eyr: "1972",
             hcl: "#18171d",
             hgt: "170",
             iyr: "2018",
             pid: "186cm"
           }
           |> Day4.Passport.valid?() == false
  end

  test "it finds invalid passports" do
    input =
      "eyr:1972 cid:100
hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

iyr:2019
hcl:#602927 eyr:1967 hgt:170cm
ecl:grn pid:012533040 byr:1946

hcl:dab227 iyr:2012
ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

hgt:59cm ecl:zzz
eyr:2038 hcl:74454a iyr:2023
pid:3556412378 byr:2007"
      |> String.split("\n\n")

    assert Day4.process_batch(input) |> Enum.count() == 0
  end

  test "it finds valid passports" do
    input =
      "pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
hcl:#623a2f

eyr:2029 ecl:blu cid:129 byr:1989
iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

hcl:#888785
hgt:164cm byr:2001 iyr:2015 cid:88
pid:545766238 ecl:hzl
eyr:2022

iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719"
      |> String.split("\n\n")

    assert Day4.process_batch(input) |> Enum.count() == 4
  end
end
