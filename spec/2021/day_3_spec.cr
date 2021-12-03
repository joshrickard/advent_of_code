require "spec"
require "../../src/2021/day_3"

describe Year2021::Day3 do
  it "solves part 1" do
    example = <<-EOS
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
    EOS
    result = Year2021::Day3::Part1.run(IO::Memory.new(example))
    result.should eq(198)
  end

  it "solves part 2" do
    example = <<-EOS
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
    EOS
    result = Year2021::Day3::Part2.run(IO::Memory.new(example))
    result.should eq(230)
  end
end
