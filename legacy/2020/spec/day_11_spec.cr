require "spec"
require "./spec_helper"
require "../src/day_11"

describe Program do
  describe "problem 1" do
    describe "example 1" do
      it "returns the expected number of occupied seats" do
        file_path = Data.example_file_path(11, 1)
        layout = SeatLayoutParser.parse(file_path, AdjacentSeatLayout)
        layout = SeatingSimulator.simulate_until_stable(layout)
        layout.occupied_seats_count.should eq 37
      end
    end

    describe "solution" do
      it "returns the expected number of occupied seats" do
        file_path = Data.input_file_path(11)
        layout = SeatLayoutParser.parse(file_path, AdjacentSeatLayout)
        layout = SeatingSimulator.simulate_until_stable(layout)
        layout.occupied_seats_count.should eq 2194
      end
    end
  end

  describe "problem 2" do
    describe "example 1" do
      it "returns the expected number of occupied seats" do
        file_path = Data.example_file_path(11, 1)
        layout = SeatLayoutParser.parse(file_path, VisibleSeatLayout)
        layout = SeatingSimulator.simulate_until_stable(layout)
        layout.occupied_seats_count.should eq 26
      end
    end

    describe "solution" do
      it "returns the expected number of occupied seats" do
        file_path = Data.input_file_path(11)
        layout = SeatLayoutParser.parse(file_path, VisibleSeatLayout)
        layout = SeatingSimulator.simulate_until_stable(layout)
        layout.occupied_seats_count.should eq 1944
      end
    end
  end
end
