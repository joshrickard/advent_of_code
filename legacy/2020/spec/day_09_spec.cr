require "spec"
require "./spec_helper"
require "../src/day_09"

describe Program do
  describe "problem 1" do
    describe "example 1" do
      it "returns the expected invalid sum" do
        file_path = Data.example_file_path(9, 1)
        xmas = XMAS.new(file_path, 5)
        xmas.invalid_sums.first.should eq 127
      end
    end

    describe "solution" do
      it "returns the expected invalid sum" do
        file_path = Data.input_file_path(9)
        xmas = XMAS.new(file_path)
        xmas.invalid_sums.first.should eq 29221323
      end
    end
  end

  describe "problem 2" do
    describe "example 2" do
      it "returns the expected encryption weakness" do
        file_path = Data.example_file_path(9, 1)
        xmas = XMAS.new(file_path, 5)
        xmas.encryption_weakness.should eq 62
      end
    end

    describe "solution" do
      it "returns the expected accumulator value" do
        file_path = Data.input_file_path(9)
        xmas = XMAS.new(file_path)
        xmas.encryption_weakness.should eq 4389369
      end
    end
  end
end
