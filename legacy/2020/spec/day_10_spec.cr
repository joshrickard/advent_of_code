require "spec"
require "./spec_helper"
require "../src/day_10"

describe Program do
  describe "problem 1" do
    describe "example 1" do
      it "returns the expected jolt deltas" do
        file_path = Data.example_file_path(10, 1)
        adapter_chain = AdapterChain.new(AdapterParser.parse(file_path))
        counts_by_jolt_delta = adapter_chain.counts_by_jolt_delta
        counts_by_jolt_delta[1].should eq 7
        counts_by_jolt_delta[3].should eq 5
      end
    end

    describe "example 2" do
      it "returns the expected jolt deltas" do
        file_path = Data.example_file_path(10, 2)
        adapter_chain = AdapterChain.new(AdapterParser.parse(file_path))
        counts_by_jolt_delta = adapter_chain.counts_by_jolt_delta
        counts_by_jolt_delta[1].should eq 22
        counts_by_jolt_delta[3].should eq 10
      end
    end

    describe "solution" do
      it "returns the expected jot deltas" do
        file_path = Data.input_file_path(10)
        adapter_chain = AdapterChain.new(AdapterParser.parse(file_path))
        counts_by_jolt_delta = adapter_chain.counts_by_jolt_delta
        (counts_by_jolt_delta[1] * counts_by_jolt_delta[3]).should eq 1998
      end
    end
  end

  describe "problem 2" do
    describe "example 1" do
      it "returns the expected number of arrangements" do
        file_path = Data.example_file_path(10, 1)
        adapter_chain = AdapterChain.new(AdapterParser.parse(file_path))
        adapter_chain.count_arrangements.should eq 8
      end
    end

    describe "example 2" do
      it "returns the expected number of arrangements" do
        file_path = Data.example_file_path(10, 2)
        adapter_chain = AdapterChain.new(AdapterParser.parse(file_path))
        adapter_chain.count_arrangements.should eq 19208
      end
    end

    describe "solution" do
      it "returns the expected number of arrangements" do
        file_path = Data.input_file_path(10)
        adapter_chain = AdapterChain.new(AdapterParser.parse(file_path))
        adapter_chain.count_arrangements.should eq 347250213298688
      end
    end
  end
end
