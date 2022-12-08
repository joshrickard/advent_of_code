require "spec"
require "../../src/2022/day_8"

describe Year2022::Day8 do
  it "solves part 1" do
    example = <<-EOS
    30373
    25512
    65332
    33549
    35390
    EOS
    result = Year2022::Day8::Part1.run(IO::Memory.new(example))
    result.should eq(21)
  end

  it "solves part 2" do
    example = <<-EOS
    30373
    25512
    65332
    33549
    35390
    EOS
    result = Year2022::Day8::Part2.run(IO::Memory.new(example))
    result.should eq(8)
  end
end
