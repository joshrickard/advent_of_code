require "../utils/runner"

# https://adventofcode.com/2021/day/9

module Year2021::Day9
  class Part1
    def self.run(input : IO)
      map = Array(Array(Int32)).new

      input.each_line do |line|
        map << line.chars.map(&.to_i)
      end

      height = map.size
      width = map[0].size

      sum_of_risk = 0
      (0...height).each do |y|
        (0...width).each do |x|
          current_height = map[y][x]
          if (y == 0 || current_height < map[y - 1][x]) &&
             (y == height - 1 || current_height < map[y + 1][x]) &&
             (x == 0 || current_height < map[y][x - 1]) &&
             (x == width - 1 || current_height < map[y][x + 1])
            sum_of_risk += current_height + 1
          end
        end
      end

      sum_of_risk
    end
  end

  class Part2
    def self.run(input : IO)
      map = Array(Array(Int32)).new

      input.each_line do |line|
        map << line.chars.map(&.to_i)
      end

      height = map.size
      width = map[0].size

      low_points = Array(NamedTuple(x: Int32, y: Int32)).new
      (0...height).each do |y|
        (0...width).each do |x|
          current_height = map[y][x]
          if (y == 0 || current_height < map[y - 1][x]) &&
             (y == height - 1 || current_height < map[y + 1][x]) &&
             (x == 0 || current_height < map[y][x - 1]) &&
             (x == width - 1 || current_height < map[y][x + 1])
            low_points << {x: x, y: y}
          end
        end
      end

      basin_sizes = Array(Int32).new
      low_points.each do |low_point|
        closed = Set(NamedTuple(x: Int32, y: Int32)).new
        open = Set(NamedTuple(x: Int32, y: Int32)).new
        open << low_point

        while open.size > 0
          current = open.first
          open.delete(current)
          closed << current
          x, y = current[:x], current[:y]

          if (y > 0 && map[y - 1][x] != 9)
            north = {x: x, y: y - 1}
            open << north unless closed.includes?(north)
          end

          if (y < height - 1 && map[y + 1][x] != 9)
            south = {x: x, y: y + 1}
            open << south unless closed.includes?(south)
          end

          if (x > 0 && map[y][x - 1] != 9)
            east = {x: x - 1, y: y}
            open << east unless closed.includes?(east)
          end

          if (x < width - 1 && map[y][x + 1] != 9)
            west = {x: x + 1, y: y}
            open << west unless closed.includes?(west)
          end
        end

        basin_sizes << closed.size
      end

      basin_sizes.sort.last(3).product
    end
  end
end

input_path = "#{__DIR__}/input/#{File.basename(__FILE__, ".cr")}.txt"

Utils::Runner.run(input_path, Year2021::Day9::Part1) if ARGV.size.positive? && ARGV.first == "part1"
Utils::Runner.run(input_path, Year2021::Day9::Part2) if ARGV.size.positive? && ARGV.first == "part2"
