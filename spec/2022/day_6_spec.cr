require "spec"
require "../../src/2022/day_6"

describe Year2022::Day6 do
  it "solves part 1" do
    example = <<-EOS
    mjqjpqmgbljsphdztnvjfqwrcgsmlb
    EOS
    result = Year2022::Day6::Part1.run(IO::Memory.new(example))
    result.should eq(7)
  end

  it "solves part 2" do
    example = <<-EOS
    nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg
    EOS
    result = Year2022::Day6::Part2.run(IO::Memory.new(example))
    result.should eq(29)
  end
end
