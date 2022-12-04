require "spec"
require "../../src/2022/day_3"

describe Year2022::Day3 do
  it "solves part 1" do
    example = <<-EOS
    vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg
    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw
    EOS
    result = Year2022::Day3::Part1.run(IO::Memory.new(example))
    result.should eq(157)
  end

  it "solves part 2" do
    example = <<-EOS
    vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg
    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw
    EOS
    result = Year2022::Day3::Part2.run(IO::Memory.new(example))
    result.should eq(70)
  end
end
