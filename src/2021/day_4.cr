require "../utils/runner"

# https://adventofcode.com/2021/day/4

module Year2021::Day4
  class InputParser
    property bingo_cards : Array(BingoCard)
    property draw_numbers : Array(Int32)

    def initialize(input : IO)
      @bingo_cards = Array(BingoCard).new
      @draw_numbers = input.read_line.split(",").map(&.to_i)

      input.gets_to_end.split(/^$/m).each do |raw_card|
        bingo_card = BingoCard.new
        raw_card.strip.split("\n").map(&.strip).each_with_index do |row, y|
          row.split(/\s+/).compact.map(&.to_i).each_with_index do |number, x|
            bingo_card.spot(x, y).number = number
          end
        end

        bingo_cards << bingo_card
      end
    end
  end

  class BingoSpot
    property marked : Bool
    property number : Int32

    def initialize(@marked = false, @number = 0)
    end
  end

  class BingoCard
    private property last_number : Int32
    private property size : Int32
    private property spots : Array(BingoSpot)

    def initialize(@size : Int32 = 5)
      @last_number = 0
      @spots = Array(BingoSpot).new

      (size * size).times { spots << BingoSpot.new }
    end

    def spot(x : Int32, y : Int32) : BingoSpot
      spots[y * size + x]
    end

    def mark_number(number : Int32) : Bool
      self.last_number = number

      spots.each_with_index do |spot, index|
        next unless spot.number == number

        spot.marked = true
        return true
      end

      false
    end

    def score : Int32
      spots.select { |s| !s.marked }
        .map(&.number)
        .sum * last_number
    end

    def winner? : Bool
      5.times do |y|
        winner = true
        5.times do |x|
          winner = spot(x, y).marked
          break if !winner
        end

        return true if winner
      end

      5.times do |x|
        winner = true
        5.times do |y|
          winner = spot(x, y).marked
          break if !winner
        end

        return true if winner
      end

      false
    end
  end

  class Part1
    def self.run(input : IO)
      input_parser = InputParser.new(input)

      input_parser.draw_numbers.each do |number|
        input_parser.bingo_cards.each do |bingo_card|
          if bingo_card.mark_number(number) && bingo_card.winner?
            return bingo_card.score
          end
        end
      end
    end
  end

  class Part2
    def self.run(input : IO)
      input_parser = InputParser.new(input)

      cards_in_play = input_parser.bingo_cards
      new_winning_cards = Array(BingoCard).new
      winning_cards = Array(BingoCard).new

      input_parser.draw_numbers.each do |number|
        new_winning_cards.clear
        cards_in_play.each do |bingo_card|
          if bingo_card.mark_number(number) && bingo_card.winner?
            new_winning_cards << bingo_card
          end
        end

        new_winning_cards.each do |bingo_card|
          cards_in_play.delete(bingo_card)
          winning_cards << bingo_card
        end
      end

      winning_cards.last.score
    end
  end
end

input_path = "#{__DIR__}/input/#{File.basename(__FILE__, ".cr")}.txt"

Utils::Runner.run(Year2021::Day4::Part1, input_path) if ARGV.size.positive? && ARGV.first == "part1"
Utils::Runner.run(Year2021::Day4::Part2, input_path) if ARGV.size.positive? && ARGV.first == "part2"
