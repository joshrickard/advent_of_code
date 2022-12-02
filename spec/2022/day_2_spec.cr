require "spec"
require "../../src/2022/day_2"

describe Year2022::Day2 do
  it "solves part 1" do
    example = <<-EOS
    A Y
    B X
    C Z
    EOS
    result = Year2022::Day2::Part1.run(IO::Memory.new(example))
    result.should eq(15)
  end

  it "solves part 2" do
    example = <<-EOS
    A Y
    B X
    C Z
    EOS
    result = Year2022::Day2::Part2.run(IO::Memory.new(example))
    result.should eq(12)
  end
end
