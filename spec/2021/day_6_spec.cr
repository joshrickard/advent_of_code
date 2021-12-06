require "spec"
require "../../src/2021/day_6"

describe Year2021::Day6 do
  it "solves part 1" do
    example = <<-EOS
    3,4,3,1,2
    EOS
    result = Year2021::Day6::Part1.run(IO::Memory.new(example))
    result.should eq(5934)
  end

  it "solves part 2" do
    example = <<-EOS
    3,4,3,1,2
    EOS
    result = Year2021::Day6::Part2.run(IO::Memory.new(example))
    result.should eq(26984457539)
  end
end
