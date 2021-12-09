require "spec"
require "../../src/2021/day_9"

describe Year2021::Day9 do
  it "solves part 1" do
    example = <<-EOS
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
    EOS
    result = Year2021::Day9::Part1.run(IO::Memory.new(example))
    result.should eq(15)
  end

  it "solves part 2" do
    example = <<-EOS
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
    EOS
    result = Year2021::Day9::Part2.run(IO::Memory.new(example))
    result.should eq(1134)
  end
end
