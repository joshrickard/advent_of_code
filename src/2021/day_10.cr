require "../utils/runner"

# https://adventofcode.com/2021/day/10

module Year2021::Day10
  class Part1
    def self.run(input : IO)
      scores_by_char = {')' => 3, ']' => 57, '}' => 1197, '>' => 25137}
      opening_chars_by_closing_char = {')' => '(', ']' => '[', '}' => '{', '>' => '<'}
      opening_chars = opening_chars_by_closing_char.values

      score = 0
      stack = Array(Char).new
      input.each_line do |line|
        stack.clear
        line.each_char do |char|
          if opening_chars.includes?(char)
            stack << char
          elsif opening_chars_by_closing_char.has_key?(char)
            if stack.last == opening_chars_by_closing_char[char]
              stack.pop
            else
              score += scores_by_char[char]
              break
            end
          end
        end
      end

      score
    end
  end

  class Part2
    def self.run(input : IO)
      scores_by_char = {')' => 1, ']' => 2, '}' => 3, '>' => 4}
      opening_chars_by_closing_char = {')' => '(', ']' => '[', '}' => '{', '>' => '<'}
      closing_chars_by_opening_char = opening_chars_by_closing_char.invert
      opening_chars = opening_chars_by_closing_char.values

      scores = Array(Int64).new
      missing = Array(Char).new
      stack = Array(Char).new
      input.each_line do |line|
        missing.clear
        stack.clear
        line.each_char do |char|
          if opening_chars.includes?(char)
            stack << char
          elsif opening_chars_by_closing_char.has_key?(char)
            if stack.last == opening_chars_by_closing_char[char]
              stack.pop
            else
              stack.clear
              break
            end
          end
        end

        while !stack.empty?
          last = stack.pop
          next if opening_chars_by_closing_char.has_key?(last)
          missing << closing_chars_by_opening_char[last]
        end

        if !missing.empty?
          score = 0_i64
          missing.each do |char|
            score *= 5
            score += scores_by_char[char]
          end
          scores << score
        end
      end

      scores.sort[(scores.size / 2).to_i32]
    end
  end
end

input_path = "#{__DIR__}/input/#{File.basename(__FILE__, ".cr")}.txt"

Utils::Runner.run(input_path, Year2021::Day10::Part1) if ARGV.size.positive? && ARGV.first == "part1"
Utils::Runner.run(input_path, Year2021::Day10::Part2) if ARGV.size.positive? && ARGV.first == "part2"
