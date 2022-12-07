require "../utils/runner"

# https://adventofcode.com/2022/day/5

module Year2022::Day5
  class CargoMoveCommand
    property quantity : Int32
    property source : Int32
    property destination : Int32

    def initialize(@quantity, @source, @destination); end
  end

  class CargoMoveCommandParser
    protected property input : IO

    MOVE_COMMAND = /^move (?<quantity>\d+) from (?<source>\d+) to (?<destination>\d+)$/

    def initialize(@input); end

    def each_move(&block) : Nil
      input.rewind
      input.each_line do |line|
        match = MOVE_COMMAND.match(line)
        next if match.nil?

        yield CargoMoveCommand.new(
          quantity: match["quantity"].to_i,
          source: match["source"].to_i,
          destination: match["destination"].to_i,
        )
      end
    end
  end

  class CargoStack
    protected getter containers : Array(Char)

    def initialize
      @containers = Array(Char).new
    end

    def peek : Char
      containers.last
    end

    def pop : Char
      containers.pop
    end

    def push(container : Char) : Nil
      containers.push(container)
    end
  end

  class CargoManifestParser
    protected property input : IO

    def initialize(@input); end

    def stacks : Array(CargoStack)
      stacks = Array(CargoStack).new
      lines = stack_lines
      stack_count = (lines.first.size + 1) / 4
      i = 0
      while i < stack_count
        cargo_stack = CargoStack.new
        j = 0
        while j < lines.size
          container = lines[j][i * 4 + 1]
          cargo_stack.push(container) if container != ' '
          j += 1
        end

        stacks << cargo_stack
        i += 1
      end

      stacks
    end

    protected def stack_lines : Array(String)
      raw_stacks = Array(String).new
      input.rewind
      input.each_line do |line|
        break unless line.includes?("[")

        raw_stacks << line
      end

      raw_stacks.reverse
    end
  end

  class Part1
    def self.run(input : IO)
      cargo_stacks = CargoManifestParser.new(input).stacks

      CargoMoveCommandParser.new(input).each_move do |move|
        move.quantity.times do
          container = cargo_stacks[move.source - 1].pop
          cargo_stacks[move.destination - 1].push(container)
        end
      end

      cargo_stacks.map(&.peek).join("")
    end
  end

  class Part2
    def self.run(input : IO)
      cargo_stacks = CargoManifestParser.new(input).stacks

      CargoMoveCommandParser.new(input).each_move do |move|
        containers_to_move = Array(Char).new
        move.quantity.times do
          containers_to_move << cargo_stacks[move.source - 1].pop
        end
        containers_to_move.reverse.each do |container|
          cargo_stacks[move.destination - 1].push(container)
        end
      end

      cargo_stacks.map(&.peek).join("")
    end
  end
end

input_path = "#{__DIR__}/input/#{File.basename(__FILE__, ".cr")}.txt"

Utils::Runner.run(input_path, Year2022::Day5::Part1) if ARGV.size.positive? && ARGV.first == "part1"
Utils::Runner.run(input_path, Year2022::Day5::Part2) if ARGV.size.positive? && ARGV.first == "part2"
