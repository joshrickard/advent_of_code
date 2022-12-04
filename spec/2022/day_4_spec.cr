require "spec"
require "../../src/2022/day_4"

describe Year2022::Day4 do
  it "solves part 1" do
    example = <<-EOS
    2-4,6-8
    2-3,4-5
    5-7,7-9
    2-8,3-7
    6-6,4-6
    2-6,4-8
    EOS
    result = Year2022::Day4::Part1.run(IO::Memory.new(example))
    result.should eq(2)
  end

  it "solves part 2" do
    example = <<-EOS
    2-4,6-8
    2-3,4-5
    5-7,7-9
    2-8,3-7
    6-6,4-6
    2-6,4-8
    EOS
    result = Year2022::Day4::Part2.run(IO::Memory.new(example))
    result.should eq(4)
  end
end
