# https://adventofcode.com/2021/day/1

module Year2021
  module Day1
    class Part1
      def self.run(input : IO)
        input
          .each_line
          .map(&.to_i)
          .each
          .cons(2)
          .count { |depths| depths[1] > depths[0] }
      end
    end

    class Part2
      def self.run(input : IO)
        input
          .each_line
          .map(&.to_i)
          .each
          .cons(3)
          .map(&.sum)
          .each
          .cons(2)
          .count { |depths| depths[1] > depths[0] }
      end
    end
  end
end

input = File.open("#{__DIR__}/input/#{File.basename(__FILE__, ".cr")}.txt")

p! Year2021::Day1::Part1.run(input) if ARGV.size.positive? && ARGV.first == "part1"
p! Year2021::Day1::Part2.run(input) if ARGV.size.positive? && ARGV.first == "part2"
