class AdapterParser
  def self.parse(file_path : String, device_jolt_delta : Int32 = 3) : Array(Int32)
    adapters = File.read(file_path).split("\n").map { |a| a.to_i }
    adapters << 0
    adapters << adapters.max + device_jolt_delta
    adapters.sort
  end
end

class AdapterChain
  private getter adapters : Array(Int32)
  getter chain_counts_by_adapter : Hash(Int32, Int64)

  def initialize(@adapters)
    @chain_counts_by_adapter = Hash(Int32, Int64).new
  end

  def counts_by_jolt_delta : Hash(Int32, Int32)
    results = Hash(Int32, Int32).new

    last_adapter = adapters.shift
    while adapters.size > 0
      adapter = adapters.shift
      delta = adapter - last_adapter
      results[delta] ||= 0
      results[delta] += 1
      last_adapter = adapter
    end

    results
  end

  def count_arrangements(i : Int32 = 0, max_delta : Int32 = 3) : Int64
    return 1_i64 if i == adapters.size - 1

    sum = 0_i64
    j = i + 1
    while j < adapters.size
      current_adapter, last_adapter = adapters[j], adapters[i]
      break if current_adapter - last_adapter > max_delta

      # Check our cache to see if we've already calculated this tree branch
      value = chain_counts_by_adapter.fetch(current_adapter) do
        # Otherwise calculate it
        chain_counts_by_adapter[current_adapter] = count_arrangements(j)
      end

      sum += value
      j = j + 1
    end

    sum
  end
end
