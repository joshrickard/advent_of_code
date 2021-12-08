require "../utils/runner"

# https://adventofcode.com/2021/day/7

module Year2021::Day7
  class Part1
    def self.run(input : IO)
      positions = input.gets_to_end.split(",").map(&.to_i)
      min_position = positions.min
      max_position = positions.max

      cheapest_cost = Int32::MAX

      (min_position..max_position).each do |position|
        current_cost = positions.map { |p| (position - p).abs }.sum
        if current_cost < cheapest_cost
          cheapest_cost = current_cost
        end
      end

      cheapest_cost
    end
  end

  class Part2
    def self.run(input : IO)
      positions = input.gets_to_end.split(",").map(&.to_i)
      min_position = positions.min
      max_position = positions.max

      cheapest_cost = Int32::MAX

      (min_position..max_position).map do |position|
        current_cost = positions.map do |p|
          (position - p).abs.times.map { |i| i + 1 }.sum
        end.sum

        if current_cost < cheapest_cost
          cheapest_cost = current_cost
        end
      end

      cheapest_cost
    end
  end
end

input_path = "#{__DIR__}/input/#{File.basename(__FILE__, ".cr")}.txt"

Utils::Runner.run(input_path, Year2021::Day7::Part1) if ARGV.size.positive? && ARGV.first == "part1"
Utils::Runner.run(input_path, Year2021::Day7::Part2) if ARGV.size.positive? && ARGV.first == "part2"
