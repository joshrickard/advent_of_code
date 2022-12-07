require "spec"
require "../../src/2022/day_5"

describe Year2022::Day5 do
  it "solves part 1" do
    example = <<-EOS
        [D]    
    [N] [C]    
    [Z] [M] [P]
     1   2   3 

    move 1 from 2 to 1
    move 3 from 1 to 3
    move 2 from 2 to 1
    move 1 from 1 to 2
    EOS
    result = Year2022::Day5::Part1.run(IO::Memory.new(example))
    result.should eq("CMZ")
  end

  it "solves part 2" do
    example = <<-EOS
        [D]    
    [N] [C]    
    [Z] [M] [P]
     1   2   3 

    move 1 from 2 to 1
    move 3 from 1 to 3
    move 2 from 2 to 1
    move 1 from 1 to 2
    EOS
    result = Year2022::Day5::Part2.run(IO::Memory.new(example))
    result.should eq("MCD")
  end
end
