require "spec"
require "../../src/2022/day_1"

describe Year2022::Day1 do
  it "solves part 1" do
    example = <<-EOS
    1000
    2000
    3000

    4000

    5000
    6000

    7000
    8000
    9000

    10000
    EOS
    result = Year2022::Day1::Part1.run(IO::Memory.new(example))
    result.should eq(24_000)
  end

  it "solves part 2" do
    example = <<-EOS
    1000
    2000
    3000

    4000

    5000
    6000

    7000
    8000
    9000

    10000
    EOS
    result = Year2022::Day1::Part2.run(IO::Memory.new(example))
    result.should eq(45000)
  end
end
