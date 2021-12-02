require "spec"
require "../../src/2021/day_2"

describe Year2021::Day2 do
  it "solves part 1" do
    example = <<-EOS
    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
    EOS
    result = Year2021::Day2::Part1.run(IO::Memory.new(example))
    result.should eq(150)
  end

  it "solves part 2" do
    example = <<-EOS
    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
    EOS
    result = Year2021::Day2::Part2.run(IO::Memory.new(example))
    result.should eq(900)
  end
end
