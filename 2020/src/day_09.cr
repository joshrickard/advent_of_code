class XMAS
  private getter encrypted_elements : Array(Int64)
  private getter preamble_length : Int32

  def initialize(file_path : String, @preamble_length : Int32 = 25)
    @encrypted_elements = File.read(file_path).split("\n").map { |e| e.to_i64 }
  end

  def encryption_weakness : Int64
    first_invalid_sum = invalid_sums.first
    start_index = 0
    contiguous_elements = Array(Int64).new
    while start_index < encrypted_elements.size - 1
      contiguous_elements.clear
      end_index = start_index
      while end_index < encrypted_elements.size
        contiguous_elements << encrypted_elements[end_index]
        if contiguous_elements.size > 1 && contiguous_elements.sum == first_invalid_sum
          return contiguous_elements.min + contiguous_elements.max
        end

        end_index += 1
      end
      start_index += 1
    end

    raise "encryption_weakness not found"
  end

  def invalid_sums : Array(Int64)
    elements = Array(Int64).new
    invalids = Array(Int64).new

    encrypted_elements.each do |element|
      if elements.size < preamble_length
        elements << element
      else
        invalids << element unless valid?(elements, element)

        elements.shift
        elements << element
      end
    end

    invalids
  end

  def valid?(elements : Array(Int64), element : Int64) : Bool
    elements.each_combination(2) do |(a, b)|
      next if a == b

      return true if a + b == element
    end

    false
  end
end
