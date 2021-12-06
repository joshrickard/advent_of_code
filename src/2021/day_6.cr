require "../utils/runner"

# https://adventofcode.com/2021/day/6

module Year2021::Day6
  class Simulation
    private property lantern_fish_counts_by_age : Hash(Int32, Int64)

    def initialize(lantern_fish_ages : Array(Int32))
      @lantern_fish_counts_by_age = Hash(Int32, Int64).new(0)
      lantern_fish_ages.each do |age|
        lantern_fish_counts_by_age[age] += 1
      end
    end

    def run(generations : Int32) : Int64
      generations.times do |i|
        next_generation = Hash(Int32, Int64).new(0)

        lantern_fish_counts_by_age.each do |age, count|
          if age == 0
            next_generation[6] += count
            next_generation[8] += count
          else
            next_generation[age - 1] += count
          end
        end

        self.lantern_fish_counts_by_age = next_generation
      end

      lantern_fish_counts_by_age.values.sum
    end
  end

  class Part1
    def self.run(input : IO)
      simulation = Simulation.new(input.gets_to_end.split(",").map(&.to_i))
      simulation.run(80)
    end
  end

  class Part2
    def self.run(input : IO)
      simulation = Simulation.new(input.gets_to_end.split(",").map(&.to_i))
      simulation.run(256)
    end
  end
end

input_path = "#{__DIR__}/input/#{File.basename(__FILE__, ".cr")}.txt"

Utils::Runner.run(input_path, Year2021::Day6::Part1) if ARGV.size.positive? && ARGV.first == "part1"
Utils::Runner.run(input_path, Year2021::Day6::Part2) if ARGV.size.positive? && ARGV.first == "part2"
