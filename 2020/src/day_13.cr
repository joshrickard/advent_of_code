require "./data"

module Day13
  class ScheduleParser
    def self.parse(file_path : String) : Tuple(Int64, Schedule)
      departure_time, buses = File.read(file_path).split("\n")

      {
        departure_time.to_i64,
        Schedule.new(
          buses.split(",").map do |id|
            if id == "x"
              Bus.new(-1_i64, true)
            else
              Bus.new(id.to_i64, false)
            end
          end
        ),
      }
    end
  end

  class Bus
    getter id : Int64
    getter wildcard : Bool

    def initialize(@id, @wildcard)
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

    def wildcard? : Bool
      wildcard
    end
  end

  class Schedule
    private getter buses : Array(Bus)

    def initialize(@buses)
    end

    def first_sequential_time : Int64
      i = 0_i64
      t = buses.first.id
      loop do
        puts t.format if i % 1_000_000 == 0
        found = true
        buses.each_with_index do |bus, i|
          next if bus.id == 0 || bus.wildcard?

          if bus.next_departure(t) != t + i
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
      buses.select { |b| !b.wildcard }
        .min_by { |b| b.next_departure(departure_time) }
    end
  end
end
