require "../utils/runner"

# https://adventofcode.com/2021/day/5

module Year2021::Day5
  class InputParser
    private property input : IO

    def initialize(@input); end

    def each_line(&block)
      input.each_line do |input_line|
        p1, p2 = input_line.split(" -> ")
        x1, y1 = p1.split(",").map(&.to_i)
        x2, y2 = p2.split(",").map(&.to_i)

        line = Line.new(x1, y1, x2, y2)
        yield line
      end
    end
  end

  struct Point
    property x : Int32
    property y : Int32

    def initialize(@x, @y); end
  end

  struct Line
    property p1 : Point
    property p2 : Point

    def initialize(x1, y1, x2, y2)
      @p1 = Point.new(x1, y1)
      @p2 = Point.new(x2, y2)
    end

    def diagonal?
      p1.x != p2.x && p1.y != p2.y
    end

    def each_point(&block)
      x_step = -(p1.x <=> p2.x)
      y_step = -(p1.y <=> p2.y)

      x = p1.x
      y = p1.y

      loop do
        yield Point.new(x, y)

        x += x_step
        y += y_step

        break if x == p2.x && y == p2.y
      end

      yield p2
    end
  end

  class Part1
    def self.run(input : IO)
      counts_by_point = Hash(Point, Int32).new

      InputParser.new(input).each_line do |line|
        next if line.diagonal?

        line.each_point do |point|
          counts_by_point[point] ||= 0
          counts_by_point[point] += 1
        end
      end

      counts_by_point.values.count { |c| c > 1 }
    end
  end

  class Part2
    def self.run(input : IO)
      counts_by_point = Hash(Point, Int32).new

      InputParser.new(input).each_line do |line|
        line.each_point do |point|
          counts_by_point[point] ||= 0
          counts_by_point[point] += 1
        end
      end

      counts_by_point.values.count { |c| c > 1 }
    end
  end
end

input_path = "#{__DIR__}/input/#{File.basename(__FILE__, ".cr")}.txt"

Utils::Runner.run(input_path, Year2021::Day5::Part1) if ARGV.size.positive? && ARGV.first == "part1"
Utils::Runner.run(input_path, Year2021::Day5::Part2) if ARGV.size.positive? && ARGV.first == "part2"
