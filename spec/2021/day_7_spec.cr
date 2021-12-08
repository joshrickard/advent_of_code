require "spec"
require "../../src/2021/day_7"

describe Year2021::Day7 do
  it "solves part 1" do
    example = <<-EOS
    16,1,2,0,4,2,7,1,2,14
    EOS
    result = Year2021::Day7::Part1.run(IO::Memory.new(example))
    result.should eq(37)
  end

  it "solves part 2" do
    example = <<-EOS
    16,1,2,0,4,2,7,1,2,14
    EOS
    result = Year2021::Day7::Part2.run(IO::Memory.new(example))
    result.should eq(168)
  end
end
