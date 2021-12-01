require "spec"
require "./spec_helper"
require "../src/day_13"

describe Day13 do
  describe "problem 1" do
    describe "example 1" do
      it "returns the expected bus and wait time" do
        file_path = Data.example_file_path(13, 1)
        departure_time, schedule = Day13::ScheduleParser.parse(file_path)
        next_departing_bus = schedule.next_departing_bus(departure_time)
        next_departing_bus.id.should eq 59
        wait_time = next_departing_bus.wait_time(departure_time)
        wait_time.should eq 5
        (wait_time * next_departing_bus.id).should eq 295
      end
    end

    describe "solution" do
      it "returns the expected bus and wait time" do
        file_path = Data.input_file_path(13)
        departure_time, schedule = Day13::ScheduleParser.parse(file_path)
        next_departing_bus = schedule.next_departing_bus(departure_time)
        next_departing_bus.id.should eq 17
        wait_time = next_departing_bus.wait_time(departure_time)
        wait_time.should eq 7
        (wait_time * next_departing_bus.id).should eq 119
      end
    end
  end

  describe "problem 2" do
    describe "example 1" do
      it "returns the expected number of occupied seats" do
        file_path = Data.example_file_path(13, 1)
        departure_time, schedule = Day13::ScheduleParser.parse(file_path)
        t = schedule.first_sequential_time
        t.should eq 1068781
      end
    end

    describe "example 2" do
      it "returns the expected number of occupied seats" do
        file_path = Data.example_file_path(13, 2)
        departure_time, schedule = Day13::ScheduleParser.parse(file_path)
        t = schedule.first_sequential_time
        t.should eq 3417
      end
    end

    describe "example 3" do
      it "returns the expected number of occupied seats" do
        file_path = Data.example_file_path(13, 3)
        departure_time, schedule = Day13::ScheduleParser.parse(file_path)
        t = schedule.first_sequential_time
        t.should eq 754018
      end
    end

    describe "example 4" do
      it "returns the expected number of occupied seats" do
        file_path = Data.example_file_path(13, 4)
        departure_time, schedule = Day13::ScheduleParser.parse(file_path)
        t = schedule.first_sequential_time
        t.should eq 779210
      end
    end

    describe "example 5" do
      it "returns the expected number of occupied seats" do
        file_path = Data.example_file_path(13, 5)
        departure_time, schedule = Day13::ScheduleParser.parse(file_path)
        t = schedule.first_sequential_time
        t.should eq 1261476
      end
    end

    describe "example 6" do
      it "returns the expected number of occupied seats" do
        file_path = Data.example_file_path(13, 6)
        departure_time, schedule = Day13::ScheduleParser.parse(file_path)
        t = schedule.first_sequential_time
        t.should eq 1202161486
      end
    end

    # describe "solution" do
    #   it "returns the expected number of occupied seats" do
    #     file_path = Data.input_file_path(13)
    #     departure_time, schedule = Day13::ScheduleParser.parse(file_path)
    #     t = schedule.first_sequential_time(100_000_000_000_000)
    #     t.should eq 0
    #   end
    # end
  end
end
