require "../utils/runner"

# https://adventofcode.com/2022/day/6

module Year2022::Day6
  class Part1
    def self.run(input : IO)
      i, size = 0, 4
      input.gets_to_end.chars.each_cons(size) do |list|
        break if list.uniq.size == size
        i += 1
      end

      i + size
    end
  end

  class Part2
    def self.run(input : IO)
      i, size = 0, 14
      input.gets_to_end.chars.each_cons(size) do |list|
        break if list.uniq.size == size
        i += 1
      end

      i + size
    end
  end
end

input_path = "#{__DIR__}/input/#{File.basename(__FILE__, ".cr")}.txt"

Utils::Runner.run(input_path, Year2022::Day6::Part1) if ARGV.size.positive? && ARGV.first == "part1"
Utils::Runner.run(input_path, Year2022::Day6::Part2) if ARGV.size.positive? && ARGV.first == "part2"
