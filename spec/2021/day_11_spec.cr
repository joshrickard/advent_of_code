require "spec"
require "../../src/2021/day_11"

describe Year2021::Day11 do
  it "solves part 1" do
    example = <<-EOS
    5483143223
    2745854711
    5264556173
    6141336146
    6357385478
    4167524645
    2176841721
    6882881134
    4846848554
    5283751526
    EOS
    result = Year2021::Day11::Part1.run(IO::Memory.new(example))
    result.should eq(1656)
  end

  it "solves part 2" do
    example = <<-EOS
    5483143223
    2745854711
    5264556173
    6141336146
    6357385478
    4167524645
    2176841721
    6882881134
    4846848554
    5283751526
    EOS
    result = Year2021::Day11::Part2.run(IO::Memory.new(example))
    result.should eq(195)
  end
end
