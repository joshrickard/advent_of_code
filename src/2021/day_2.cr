require "../utils/runner"

# https://adventofcode.com/2021/day/2

module Year2021
  module Day2
    enum Direction
      Down
      Forward
      Up
    end

    struct Command
      property direction : Direction
      property distance : Int32

      def initialize(@direction, @distance); end
    end

    class CommandParser
      include Enumerable(Command)

      private getter input : IO

      def initialize(@input); end

      def each(&block)
        input.each_line do |line|
          direction, distance = line.split(" ")

          yield Command.new(Direction.parse(direction), distance.to_i)
        end
      end
    end

    class Part1
      class Position
        property depth : Int32
        property horizontal : Int32

        def initialize(@depth = 0, @horizontal = 0)
        end
      end

      def self.run(input : IO)
        position = Position.new

        CommandParser.new(input).each do |command|
          case command.direction
          when Direction::Down
            position.depth += command.distance
          when Direction::Forward
            position.horizontal += command.distance
          when Direction::Up
            position.depth -= command.distance
          else
            raise "Unhandled direction: #{command.direction}"
          end
        end

        position.depth * position.horizontal
      end
    end

    class Part2
      class Position
        property aim : Int32
        property depth : Int32
        property horizontal : Int32

        def initialize(@aim = 0, @depth = 0, @horizontal = 0)
        end
      end

      def self.run(input : IO)
        position = Position.new

        CommandParser.new(input).each do |command|
          case command.direction
          when Direction::Down
            position.aim += command.distance
          when Direction::Forward
            position.depth += position.aim * command.distance
            position.horizontal += command.distance
          when Direction::Up
            position.aim -= command.distance
          else
            raise "Unhandled direction: #{command.direction}"
          end
        end

        position.depth * position.horizontal
      end
    end
  end
end

input_path = "#{__DIR__}/input/#{File.basename(__FILE__, ".cr")}.txt"

Utils::Runner.run(Year2021::Day2::Part1, input_path) if ARGV.size.positive? && ARGV.first == "part1"
Utils::Runner.run(Year2021::Day2::Part2, input_path) if ARGV.size.positive? && ARGV.first == "part2"
