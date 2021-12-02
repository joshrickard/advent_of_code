require "spec"
require "../../src/2021/day_1"

describe Year2021::Day1 do
  it "solves part 1" do
    example = <<-EOS
    199
    200
    208
    210
    200
    207
    240
    269
    260
    263
    EOS
    result = Year2021::Day1::Part1.run(IO::Memory.new(example))
    result.should eq(7)
  end

  it "solves part 2" do
    example = <<-EOS
    199
    200
    208
    210
    200
    207
    240
    269
    260
    263
    EOS
    result = Year2021::Day1::Part2.run(IO::Memory.new(example))
    result.should eq(5)
  end
end
