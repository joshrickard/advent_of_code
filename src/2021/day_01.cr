# https://adventofcode.com/2021/day/1

module Year2021
  module Day01
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

# puts Year2021::Day01::Part1.run(File.open("#{__DIR__}/input/day_01.txt"))
# puts Year2021::Day01::Part2.run(File.open("#{__DIR__}/input/day_01.txt"))
