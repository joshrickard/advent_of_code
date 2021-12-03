require "../utils/runner"

# https://adventofcode.com/2021/day/3

module Year2021::Day3
  class BitsParser
    getter bit_count : Int32
    getter values : Array(Int32)

    def initialize(input : IO)
      @bit_count = input.read_line.size
      @values = Array(Int32).new

      input.rewind
      input.each_line do |line|
        values << line.to_i(2)
      end
    end
  end

  class BitFrequencyCounter
    private getter bit_count : Int32
    private getter bit_sums : Array(Int32)
    property decimal_values : Array(Int32)

    def initialize(bit_count : Int32, values : Array(Int32))
      @bit_count = bit_count
      @bit_sums = Array(Int32).new(bit_count, 0)
      @decimal_values = values.clone

      recalculate_bit_sums!
    end

    def decimal_bit_position(ltr_position : Int32) : Int32
      bit_count - ltr_position - 1
    end

    def delete_unless_bit_set!(bit : Int32, ltr_position : Int32)
      shift_count = decimal_bit_position(ltr_position)
      mask = 1 << shift_count

      decimal_values.select! do |value|
        bit == ((mask & value) >> shift_count)
      end

      recalculate_bit_sums!
    end

    def least_common_bits_with_position(bit_if_equal : Int32 = 0, &block) : Nil
      bit_count.times do |ltr_position|
        yield least_common_bit_at(ltr_position, bit_if_equal, decimal_values.size / 2), ltr_position
      end
    end

    def most_common_bits_with_position(bit_if_equal : Int32 = 0, &block) : Nil
      bit_count.times do |ltr_position|
        yield most_common_bit_at(ltr_position, bit_if_equal, decimal_values.size / 2), ltr_position
      end
    end

    private def least_common_bit_at(ltr_position : Int32, bit_if_equal : Int32, majority_size) : Int32
      if bit_sums[ltr_position] > majority_size
        0
      elsif bit_sums[ltr_position] < majority_size
        1
      else
        bit_if_equal
      end
    end

    private def most_common_bit_at(ltr_position : Int32, bit_if_equal : Int32, majority_size) : Int32
      if bit_sums[ltr_position] > majority_size
        1
      elsif bit_sums[ltr_position] < majority_size
        0
      else
        bit_if_equal
      end
    end

    private def recalculate_bit_sums! : Nil
      bit_sums.size.times { |i| bit_sums[i] = 0 }

      decimal_values.each do |value|
        update_bit_sums(value)
      end
    end

    private def update_bit_sums(value : Int32) : Nil
      bit_count.times do |ltr_position|
        shift_count = decimal_bit_position(ltr_position)
        mask = 1 << shift_count
        if (value & mask) != 0
          bit_sums[ltr_position] += 1
        end
      end
    end
  end

  class Part1
    def self.run(input : IO)
      bits_parser = BitsParser.new(input)
      bit_frequency_counter = BitFrequencyCounter.new(bits_parser.bit_count, bits_parser.values)

      gamma, epsilon = 0, 0
      bit_frequency_counter.most_common_bits_with_position do |bit, ltr_position|
        value = (1 << bit_frequency_counter.decimal_bit_position(ltr_position))
        if bit == 1
          gamma = gamma + value
        else
          epsilon = epsilon + value
        end
      end

      gamma * epsilon
    end
  end

  class Part2
    def self.run(input : IO)
      bits_parser = BitsParser.new(input)

      bit_frequency_counter = BitFrequencyCounter.new(bits_parser.bit_count, bits_parser.values)
      bit_frequency_counter.most_common_bits_with_position(bit_if_equal: 1) do |bit, ltr_position|
        break if bit_frequency_counter.decimal_values.size == 1

        bit_frequency_counter.delete_unless_bit_set!(bit, ltr_position)
      end
      oxygen_generator = bit_frequency_counter.decimal_values.first

      bit_frequency_counter = BitFrequencyCounter.new(bits_parser.bit_count, bits_parser.values)
      bit_frequency_counter.least_common_bits_with_position(bit_if_equal: 0) do |bit, ltr_position|
        break if bit_frequency_counter.decimal_values.size == 1

        bit_frequency_counter.delete_unless_bit_set!(bit, ltr_position)
      end
      co2_scrubber = bit_frequency_counter.decimal_values.first

      oxygen_generator * co2_scrubber
    end
  end
end

input_path = "#{__DIR__}/input/#{File.basename(__FILE__, ".cr")}.txt"

Utils::Runner.run(Year2021::Day3::Part1, input_path) if ARGV.size.positive? && ARGV.first == "part1"
Utils::Runner.run(Year2021::Day3::Part2, input_path) if ARGV.size.positive? && ARGV.first == "part2"
