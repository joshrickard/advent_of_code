require "../utils/runner"

# https://adventofcode.com/2022/day/4

module Year2022::Day4
  class Part1
    def self.run(input : IO)
      fully_contained_count = 0
      input.each_line do |line|
        ranges = line.split(",")
        min1, max1 = ranges[0].split("-").map(&.to_i)
        min2, max2 = ranges[1].split("-").map(&.to_i)

        if (min1 <= min2 && max1 >= max2) || (min2 <= min1 && max2 >= max1)
          fully_contained_count += 1
        end
      end
      fully_contained_count
    end
  end

  class Part2
    def self.run(input : IO)
      partially_contained_count = 0
      input.each_line do |line|
        ranges = line.split(",")
        min1, max1 = ranges[0].split("-").map(&.to_i)
        min2, max2 = ranges[1].split("-").map(&.to_i)

        if (min1 <= max2 && max1 >= min2)
          partially_contained_count += 1
        end
      end
      partially_contained_count
    end
  end
end

input_path = "#{__DIR__}/input/#{File.basename(__FILE__, ".cr")}.txt"

Utils::Runner.run(input_path, Year2022::Day4::Part1) if ARGV.size.positive? && ARGV.first == "part1"
Utils::Runner.run(input_path, Year2022::Day4::Part2) if ARGV.size.positive? && ARGV.first == "part2"
