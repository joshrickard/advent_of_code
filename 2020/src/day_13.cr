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
      bus_with_largest_interval = buses.max_by { |b| b.id }

      t = bus_with_largest_interval.next_departure(t)

      puts
      puts "t=#{t} step_size=#{bus_with_largest_interval.id} offset=#{bus_with_largest_interval.index}"

      loop_counter = 0_i64
      loop do
        puts t.format if loop_counter % 100_000_000 == 0
        found = true
        buses.each do |bus|
          t_first_bus = t - bus_with_largest_interval.index
          if bus.next_departure(t_first_bus) != t_first_bus + bus.index
            found = false
            break
          end
        end

        return t - bus_with_largest_interval.index if found

        loop_counter += 1
        t += bus_with_largest_interval.id
      end
    end

    def next_departing_bus(departure_time : Int64) : Bus
      buses.min_by { |b| b.next_departure(departure_time) }
    end
  end
end
