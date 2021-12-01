require "spec"
require "../../src/2021/day_01"

describe Year2021::Day01 do
  it "solves part 1" do
    input = IO::Memory.new(
      <<-EOS
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
    )
    result = Year2021::Day01::Part1.run(input)
    result.should eq(7)
  end

  it "solves part 2" do
    input = IO::Memory.new(
      <<-EOS
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
    )
    result = Year2021::Day01::Part2.run(input)
    result.should eq(5)
  end
end
