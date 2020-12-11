require "spec"
require "./spec_helper"
require "../src/day_07"

describe Luggage do
  describe "problem 1" do
    describe "example 1" do
      it "returns the expected top level bag colors" do
        file_path = Data.example_file_path(7, 1)
        luggage = Luggage.new(file_path)
        bag_to_store = {color: "shiny gold"}
        luggage.top_level_bag_color_options(bag_to_store).should eq [
          {color: "light red"}, {color: "dark orange"}, {color: "bright white"}, {color: "muted yellow"},
        ]
      end
    end

    describe "solution" do
      it "returns the expected top level bag colors" do
        file_path = Data.input_file_path(7)
        luggage = Luggage.new(file_path)
        bag_to_store = {color: "shiny gold"}
        luggage.top_level_bag_color_options(bag_to_store).size.should eq 257
      end
    end
  end

  describe "problem 2" do
    describe "example 1" do
      it "returns the expected inner bag count" do
        file_path = Data.example_file_path(7, 1)
        luggage = Luggage.new(file_path)
        bag = {color: "shiny gold"}
        luggage.inner_bag_count(bag).should eq 32
      end
    end

    describe "example 2" do
      it "returns the expected inner bag count" do
        file_path = Data.example_file_path(7, 2)
        luggage = Luggage.new(file_path)
        bag = {color: "shiny gold"}
        luggage.inner_bag_count(bag).should eq 126
      end
    end

    describe "solution" do
      it "returns the expected inner bag count" do
        file_path = Data.input_file_path(7)
        luggage = Luggage.new(file_path)
        bag = {color: "shiny gold"}
        luggage.inner_bag_count(bag).should eq 1038
      end
    end
  end
end
