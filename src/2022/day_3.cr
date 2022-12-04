require "../utils/runner"

# https://adventofcode.com/2022/day/3

module Year2022::Day3
  class ItemType
    protected property value : Char

    def initialize(@value); end

    def priority : Int32
      if value.ascii_lowercase?
        value.ord - 96
      elsif value.ascii_uppercase?
        value.ord - 38
      else
        raise "Unexpected code path"
      end
    end
  end

  class Rucksack
    protected property compartment1 : String
    protected property compartment2 : String

    def initialize(@compartment1, @compartment2)
    end

    def common_item_type : Char
      (compartment1.chars.to_set & compartment2.chars.to_set).first
    end

    def common_item_type_priority : Int32
      ItemType.new(common_item_type).priority
    end
  end

  class RucksackParser
    protected property input : IO

    def initialize(@input); end

    def each_rucksack(&block)
      input.each_line do |line|
        compartment1 = line[0...(line.size/2).to_i32]
        compartment2 = line[(line.size/2).to_i32...line.size]
        yield Rucksack.new(compartment1, compartment2)
      end
    end
  end

  class ElfGroup
    protected property lines : Array(String)

    def initialize(@lines); end

    def badge : Char
      (lines[0].chars.to_set & lines[1].chars.to_set & lines[2].chars.to_set).first
    end

    def badge_priority : Int32
      ItemType.new(badge).priority
    end
  end

  class ElfGroupParser
    protected property input : IO

    def initialize(@input); end

    def each_group(&block)
      lines = Array(String).new
      input.each_line do |line|
        lines << line
        if lines.size == 3
          yield ElfGroup.new(lines)
          lines.clear
        end
      end
    end
  end

  class Part1
    def self.run(input : IO)
      priority_sum = 0
      RucksackParser.new(input).each_rucksack do |rucksack|
        priority_sum += rucksack.common_item_type_priority
      end
      priority_sum
    end
  end

  class Part2
    def self.run(input : IO)
      priority_sum = 0
      ElfGroupParser.new(input).each_group do |group|
        priority_sum += group.badge_priority
      end
      priority_sum
    end
  end
end

input_path = "#{__DIR__}/input/#{File.basename(__FILE__, ".cr")}.txt"

Utils::Runner.run(input_path, Year2022::Day3::Part1) if ARGV.size.positive? && ARGV.first == "part1"
Utils::Runner.run(input_path, Year2022::Day3::Part2) if ARGV.size.positive? && ARGV.first == "part2"
