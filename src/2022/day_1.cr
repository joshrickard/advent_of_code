require "../utils/runner"

# https://adventofcode.com/2022/day/1

module Year2022::Day1
  class CalorieInputParser
    protected property input : IO

    def initialize(@input); end

    def each_elf(&block) : Nil
      current_elf_calories_count = 0
      input.each_line do |line|
        if line.blank?
          yield current_elf_calories_count
          current_elf_calories_count = 0
        else
          current_elf_calories_count += line.to_i
        end
      end

      yield current_elf_calories_count if current_elf_calories_count > 0
    end
  end

  class Part1
    def self.run(input : IO)
      greatest_elf_calories_count = 0
      CalorieInputParser.new(input).each_elf do |current_elf_calories_count|
        greatest_elf_calories_count = current_elf_calories_count if current_elf_calories_count > greatest_elf_calories_count
      end

      greatest_elf_calories_count
    end
  end

  class Part2
    def self.run(input : IO)
      top_three_elf_calories_counts = Array(Int32).new(size: 3, value: 0)
      CalorieInputParser.new(input).each_elf do |current_elf_calories_count|
        if current_elf_calories_count > top_three_elf_calories_counts[0]
          top_three_elf_calories_counts[0] = current_elf_calories_count
          top_three_elf_calories_counts.sort!
        end
      end

      top_three_elf_calories_counts.sum
    end
  end
end

input_path = "#{__DIR__}/input/#{File.basename(__FILE__, ".cr")}.txt"

Utils::Runner.run(input_path, Year2022::Day1::Part1) if ARGV.size.positive? && ARGV.first == "part1"
Utils::Runner.run(input_path, Year2022::Day1::Part2) if ARGV.size.positive? && ARGV.first == "part2"
