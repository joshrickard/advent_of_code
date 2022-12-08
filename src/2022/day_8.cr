require "../utils/runner"

# https://adventofcode.com/2022/day/8

module Year2022::Day8
  class TreeMap
    getter height : Int32
    protected property tiles : Array(Int32)
    getter width : Int32

    def initialize(input)
      lines = input.gets_to_end.split("\n").reject(&.blank?)
      @height = lines.size
      @width = lines[0].size
      @tiles = Array(Int32).new(size: width * height, value: 0)

      lines.each_with_index do |line, y|
        line.chars.each_with_index do |char, x|
          @tiles[y * width + x] = char.to_i
        end
      end
    end

    def [](x : Int32, y : Int32) : Int32
      tiles[y * width + x]
    end

    def edge?(x : Int32, y : Int32) : Bool
      x == 0 || x == (width - 1) || y == 0 || y == (height - 1)
    end

    def scenic_score(x : Int32, y : Int32) : Int32
      visible_column_count(x, y, -1) *
        visible_column_count(x, y, 1) *
        visible_row_count(x, y, -1) *
        visible_row_count(x, y, 1)
    end

    def visible?(x : Int32, y : Int32) : Bool
      edge?(x, y) ||
        visible_column?(x, y, -1) ||
        visible_column?(x, y, 1) ||
        visible_row?(x, y, 1) ||
        visible_row?(x, y, -1)
    end

    protected def visible_column?(x : Int32, y : Int32, step : Int32) : Bool
      to = step.positive? ? height - 1 : 0

      y.step(to: to, by: step, exclusive: true) do |current_y|
        return false if self[x, y] <= self[x, current_y + step]
      end

      true
    end

    protected def visible_column_count(x : Int32, y : Int32, step : Int32) : Int32
      score = 0
      to = step.positive? ? height - 1 : 0

      y.step(to: to, by: step, exclusive: true) do |current_y|
        score += 1
        break if self[x, y] <= self[x, current_y + step]
      end

      score
    end

    protected def visible_row?(x : Int32, y : Int32, step : Int32) : Bool
      to = step.positive? ? width - 1 : 0

      x.step(to: to, by: step, exclusive: true) do |current_x|
        return false if self[x, y] <= self[current_x + step, y]
      end

      true
    end

    protected def visible_row_count(x : Int32, y : Int32, step : Int32) : Int32
      score = 0
      to = step.positive? ? width - 1 : 0

      x.step(to: to, by: step, exclusive: true) do |current_x|
        score += 1
        break if self[x, y] <= self[current_x + step, y]
      end

      score
    end
  end

  class Part1
    def self.run(input : IO)
      map = TreeMap.new(input)

      x, y, visible_trees = 0, 0, 0
      (0...map.height).each do |y|
        (0...map.width).each do |x|
          visible_trees += 1 if map.visible?(x, y)
        end
      end

      visible_trees
    end
  end

  class Part2
    def self.run(input : IO)
      map = TreeMap.new(input)

      x, y, best_scenic_score = 0, 0, 0
      (0...map.height).each do |y|
        (0...map.width).each do |x|
          current_scenic_score = map.scenic_score(x, y)
          best_scenic_score = current_scenic_score if current_scenic_score > best_scenic_score
        end
      end

      best_scenic_score
    end
  end
end

input_path = "#{__DIR__}/input/#{File.basename(__FILE__, ".cr")}.txt"

Utils::Runner.run(input_path, Year2022::Day8::Part1) if ARGV.size.positive? && ARGV.first == "part1"
Utils::Runner.run(input_path, Year2022::Day8::Part2) if ARGV.size.positive? && ARGV.first == "part2"
