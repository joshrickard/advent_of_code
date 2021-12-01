require "spec"
require "./spec_helper"
require "../src/day_12"

describe Day12 do
  describe "problem 1" do
    describe "example 1" do
      it "returns the expected distance" do
        file_path = Data.example_file_path(12, 1)
        movements = Day12::MovementParser.parse(file_path)
        navigator = Day12::Navigator.new(Day12::Ship.new, movements)
        navigator.sail
        navigator.ship.manhattan_distance.should eq 25
      end
    end

    describe "solution" do
      it "returns the expected number of occupied seats" do
        file_path = Data.input_file_path(12)
        movements = Day12::MovementParser.parse(file_path)
        navigator = Day12::Navigator.new(Day12::Ship.new, movements)
        navigator.sail
        navigator.ship.manhattan_distance.should eq 1482
      end
    end
  end

  describe "problem 2" do
    describe "example 1" do
      it "returns the expected number of occupied seats" do
        file_path = Data.example_file_path(12, 1)
        movements = Day12::MovementParser.parse(file_path)
        navigator = Day12::Navigator.new(Day12::Ship.new, movements)
        navigator.sail({x: 10, y: 1})
        navigator.ship.manhattan_distance.should eq 286
      end
    end

    describe "solution" do
      it "returns the expected number of occupied seats" do
        file_path = Data.input_file_path(12)
        movements = Day12::MovementParser.parse(file_path)
        navigator = Day12::Navigator.new(Day12::Ship.new, movements)
        navigator.sail({x: 10, y: 1})
        navigator.ship.manhattan_distance.should eq 48739
      end
    end
  end
end
