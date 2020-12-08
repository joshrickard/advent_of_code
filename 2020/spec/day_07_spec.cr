require "spec"
require "../src/day_07"

describe Luggage do
  describe "problem 1" do
    describe "example 1" do
      it "returns the expected top level bag colors" do
        luggage = Luggage.new(File.join(__DIR__, "data", "day_07_example1.txt"))
        bag_to_store = {color: "shiny gold"}
        luggage.top_level_bag_color_options(bag_to_store).should eq [
          {color: "light red"}, {color: "dark orange"}, {color: "bright white"}, {color: "muted yellow"},
        ]
      end
    end

    describe "solution" do
      it "returns the expected top level bag colors" do
        luggage = Luggage.new(File.join(__DIR__, "..", "data", "day_07.txt"))
        bag_to_store = {color: "shiny gold"}
        luggage.top_level_bag_color_options(bag_to_store).size.should eq 257
      end
    end
  end

  describe "problem 2" do
    describe "example 1" do
      it "returns the expected inner bag count" do
        luggage = Luggage.new(File.join(__DIR__, "data", "day_07_example1.txt"))
        bag = {color: "shiny gold"}
        luggage.inner_bag_count(bag).should eq 32
      end
    end

    describe "example 2" do
      it "returns the expected inner bag count" do
        luggage = Luggage.new(File.join(__DIR__, "data", "day_07_example2.txt"))
        bag = {color: "shiny gold"}
        luggage.inner_bag_count(bag).should eq 126
      end
    end

    describe "solution" do
      it "returns the expected inner bag count" do
        luggage = Luggage.new(File.join(__DIR__, "..", "data", "day_07.txt"))
        bag = {color: "shiny gold"}
        luggage.inner_bag_count(bag).should eq 1038
      end
    end
  end
end
