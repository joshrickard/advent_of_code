require "./data"

module Day13
  class ScheduleParser
    def self.parse(file_path : String) : Tuple(Int64, Schedule)
      departure_time, buses = File.read(file_path).split("\n")

      results = Array(Bus).new
      buses.split(",").each_with_index do |id, i|
        next if id == "x"

        results << Bus.new(id.to_i64, i.to_i64)
      end

      {
        departure_time.to_i64,
        Schedule.new(results),
      }
    end
  end

  class Bus
    getter id : Int64
    getter index : Int64

    def initialize(@id, @index)
    end

    def next_departure(time : Int64) : Int64
      skip_ahead = (time // id)
      departure_time = id * skip_ahead
      departure_time += id if departure_time < time
      departure_time
    end

    def wait_time(time : Int64) : Int64
      next_departure(time) - time
    end
  end

  class Schedule
    private getter buses : Array(Bus)

    def initialize(@buses)
    end

    def first_sequential_time(t : Int64 = 0) : Int64
      i = 0_i64
      t = buses.first.next_departure(t)
      loop do
        puts t.format if i % 100_000_000 == 0
        found = true
        buses.each do |bus|
          if bus.next_departure(t) != t + bus.index
            found = false
            break
          end
        end

        return t if found

        i += 1
        t += buses.first.id
      end
    end

    def next_departing_bus(departure_time : Int64) : Bus
      buses.min_by { |b| b.next_departure(departure_time) }
    end
  end
end
