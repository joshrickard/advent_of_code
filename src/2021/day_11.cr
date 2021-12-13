require "../utils/runner"

# https://adventofcode.com/2021/day/11

module Year2021::Day11
  class InputParser
    private property input : IO

    def initialize(@input); end

    def map
      map = Map.new(10, 10)
      y = 0
      input.each_line do |line|
        x = 0
        line.each_char do |char|
          octopus = map.at(x, y)
          octopus.energy_level = Int32.new(char)
          octopus.x = x
          octopus.y = y
          x += 1
        end

        y += 1
      end

      map
    end
  end

  class Octopus
    property energy_level : Int32
    property flashed : Bool
    property x : Int32
    property y : Int32

    def initialize(@energy_level = 0, @flashed = false, @x = 0, @y = 0); end

    def flashable? : Bool
      energy_level > 9 && !flashed
    end
  end

  class Map
    getter height : Int32
    private property octopuses : Array(Octopus)
    getter width : Int32

    def initialize(@width, @height)
      @octopuses = Array(Octopus).new
      (0..width*height).each { octopuses << Octopus.new }
    end

    def at(x, y) : Octopus
      octopuses[y * width + x]
    end

    def neighbors(x, y, &block)
      yield at(x, y - 1) if y > 0                                 # N
      yield at(x + 1, y - 1) if x != width - 1 && y > 0           # NE
      yield at(x + 1, y) if x != width - 1                        # E
      yield at(x + 1, y + 1) if x != width - 1 && y != height - 1 # SE
      yield at(x, y + 1) if y != height - 1                       # S
      yield at(x - 1, y + 1) if x > 0 && y != height - 1          # SW
      yield at(x - 1, y) if x > 0                                 # W
      yield at(x - 1, y - 1) if x > 0 && y > 0                    # NW
    end

    def step : Int32
      increment_energy!
      flash_count = trigger_flashes!
      reset_octopuses!

      flash_count
    end

    def to_s
      height.times.map do |y|
        (0...width).map { |x| at(x, y).energy_level.to_s }.join
      end.join("\n")
    end

    private def increment_energy!(by : Int32 = 1)
      height.times do |y|
        width.times do |x|
          at(x, y).energy_level += 1
        end
      end
    end

    private def reset_octopuses!
      height.times do |y|
        width.times do |x|
          octopus = at(x, y)
          next unless octopus.flashed

          octopus.energy_level = 0
          octopus.flashed = false
        end
      end
    end

    private def trigger_flashes!
      flash_count = 0
      height.times do |y|
        width.times do |x|
          flash_count += trigger_flash(x, y)
        end
      end

      flash_count
    end

    private def trigger_flash(x, y) : Int32
      octopus = at(x, y)
      return 0 unless octopus.flashable?

      flash_count = 1
      octopus.flashed = true
      neighbors(x, y) do |neighbor|
        neighbor.energy_level += 1
        next unless neighbor.flashable?

        flash_count += trigger_flash(neighbor.x, neighbor.y)
      end

      flash_count
    end
  end

  class Part1
    def self.run(input : IO)
      map = InputParser.new(input).map

      flash_count = 0
      100.times do |i|
        flash_count += map.step
      end

      flash_count
    end
  end

  class Part2
    def self.run(input : IO)
      map = InputParser.new(input).map

      step_count = 0
      loop do
        flash_count = map.step
        step_count += 1

        break if flash_count == map.width * map.height
      end

      step_count
    end
  end
end

input_path = "#{__DIR__}/input/#{File.basename(__FILE__, ".cr")}.txt"

Utils::Runner.run(input_path, Year2021::Day11::Part1) if ARGV.size.positive? && ARGV.first == "part1"
Utils::Runner.run(input_path, Year2021::Day11::Part2) if ARGV.size.positive? && ARGV.first == "part2"
