require "../utils/runner"

# https://adventofcode.com/2022/day/2

module Year2022::Day2
  module RockPaperScissors
    enum Move
      Rock
      Paper
      Scissors

      def losing_move : Move
        case self
        when Rock     then Scissors
        when Paper    then Rock
        when Scissors then Paper
        else
          raise "Unhandled move #{self}"
        end
      end

      def winning_move : Move
        case self
        when Rock     then Paper
        when Paper    then Scissors
        when Scissors then Rock
        else
          raise "Unhandled move #{self}"
        end
      end
    end

    class Round
      getter player1_move : Move
      getter player2_move : Move

      def initialize(@player1_move, @player2_move)
      end

      def draw? : Bool
        player1_move == player2_move
      end

      def player1_wins? : Bool
        !draw? && (
          player2_move == Move::Rock && player1_move == Move::Paper ||
            player2_move == Move::Paper && player1_move == Move::Scissors ||
            player2_move == Move::Scissors && player1_move == Move::Rock
        )
      end

      def player2_wins? : Bool
        !draw? && (
          player1_move == Move::Rock && player2_move == Move::Paper ||
            player1_move == Move::Paper && player2_move == Move::Scissors ||
            player1_move == Move::Scissors && player2_move == Move::Rock
        )
      end

      def score : Int32
        value = case
                when player2_wins? then 6
                when draw?         then 3
                when player1_wins? then 0
                else
                  raise "Unexpected round outcome!"
                end

        value += case player2_move
                 when RockPaperScissors::Move::Rock     then 1
                 when RockPaperScissors::Move::Paper    then 2
                 when RockPaperScissors::Move::Scissors then 3
                 else
                   raise "Unhandled player move: #{player2_move}"
                 end
      end
    end

    class StrategyGuideDecryptorV1
      protected property input : IO

      def initialize(@input); end

      def each_round(&block) : Nil
        input.each_line do |line|
          moves = line.split(" ")

          opponent_move = case moves[0]
                          when "A" then Move::Rock
                          when "B" then Move::Paper
                          when "C" then Move::Scissors
                          else
                            raise "Unhandled opponent move: #{moves[0]}"
                          end

          your_move = case moves[1]
                      when "X" then Move::Rock
                      when "Y" then Move::Paper
                      when "Z" then Move::Scissors
                      else
                        raise "Unhandled player move: #{moves[0]}"
                      end

          yield Round.new(opponent_move, your_move)
        end
      end
    end

    class StrategyGuideDecryptorV2
      protected property input : IO

      def initialize(@input); end

      def each_round(&block) : Nil
        input.each_line do |line|
          parts = line.split(" ")

          opponent_move = case parts[0]
                          when "A" then Move::Rock
                          when "B" then Move::Paper
                          when "C" then Move::Scissors
                          else
                            raise "Unhandled opponent move: #{parts[0]}"
                          end

          your_move = case parts[1]
                      when "X" then opponent_move.losing_move
                      when "Y" then opponent_move
                      when "Z" then opponent_move.winning_move
                      else
                        raise "Unhandled player move: #{parts[0]}"
                      end

          yield Round.new(opponent_move, your_move)
        end
      end
    end
  end

  class Part1
    def self.run(input : IO)
      score = 0
      RockPaperScissors::StrategyGuideDecryptorV1.new(input).each_round do |round|
        score += round.score
      end
      score
    end
  end

  class Part2
    def self.run(input : IO)
      score = 0
      RockPaperScissors::StrategyGuideDecryptorV2.new(input).each_round do |round|
        score += round.score
      end
      score
    end
  end
end

input_path = "#{__DIR__}/input/#{File.basename(__FILE__, ".cr")}.txt"

Utils::Runner.run(input_path, Year2022::Day2::Part1) if ARGV.size.positive? && ARGV.first == "part1"
Utils::Runner.run(input_path, Year2022::Day2::Part2) if ARGV.size.positive? && ARGV.first == "part2"
