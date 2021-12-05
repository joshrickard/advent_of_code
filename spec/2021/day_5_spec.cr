require "spec"
require "../../src/2021/day_5"

describe Year2021::Day5 do
  it "solves part 1" do
    example = <<-EOS
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    EOS
    result = Year2021::Day5::Part1.run(IO::Memory.new(example))
    result.should eq(5)
  end

  it "solves part 2" do
    example = <<-EOS
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    EOS
    result = Year2021::Day5::Part2.run(IO::Memory.new(example))
    result.should eq(12)
  end
end
