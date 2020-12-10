require "spec"
require "../src/day_10"

describe Program do
  describe "problem 1" do
    describe "example 1" do
      it "returns the expected jolt deltas" do
        file_path = File.join(__DIR__, "data", "day_10_example1.txt")
        adapter_chain = AdapterChain.new(AdapterParser.parse(file_path))
        counts_by_jolt_delta = adapter_chain.counts_by_jolt_delta
        counts_by_jolt_delta[1].should eq 7
        counts_by_jolt_delta[3].should eq 5
      end
    end

    describe "example 2" do
      it "returns the expected jolt deltas" do
        file_path = File.join(__DIR__, "data", "day_10_example2.txt")
        adapter_chain = AdapterChain.new(AdapterParser.parse(file_path))
        counts_by_jolt_delta = adapter_chain.counts_by_jolt_delta
        counts_by_jolt_delta[1].should eq 22
        counts_by_jolt_delta[3].should eq 10
      end
    end

    describe "solution" do
      it "returns the expected invalid sum" do
        file_path = File.join(__DIR__, "..", "data", "day_10.txt")
        adapter_chain = AdapterChain.new(AdapterParser.parse(file_path))
        counts_by_jolt_delta = adapter_chain.counts_by_jolt_delta
        (counts_by_jolt_delta[1] * counts_by_jolt_delta[3]).should eq 1998
      end
    end
  end

  describe "problem 2" do
    describe "example 1" do
      it "returns the expected number of arrangements" do
        file_path = File.join(__DIR__, "data", "day_10_example1.txt")
        adapter_chain = AdapterChain.new(AdapterParser.parse(file_path))
        adapter_chain.count_arrangements.should eq 8
      end
    end

    describe "example 2" do
      it "returns the expected number of arrangements" do
        file_path = File.join(__DIR__, "data", "day_10_example2.txt")
        adapter_chain = AdapterChain.new(AdapterParser.parse(file_path))
        adapter_chain.count_arrangements.should eq 19208
      end
    end

    describe "solution" do
      it "returns the expected number of arrangements" do
        file_path = File.join(__DIR__, "..", "data", "day_10.txt")
        adapter_chain = AdapterChain.new(AdapterParser.parse(file_path))
        adapter_chain.count_arrangements.should eq 347250213298688
      end
    end
  end
end
