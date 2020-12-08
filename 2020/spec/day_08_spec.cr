require "spec"
require "../src/day_08"

describe Program do
  describe "problem 1" do
    describe "example 1" do
      it "returns the expected accumulator value" do
        file_path = File.join(__DIR__, "data", "day_08_example1.txt")
        program = Program.new(file_path)
        expect_raises(Program::InfiniteLoop) do
          program.execute
        end
        program.accumulator.should eq 5
      end
    end

    describe "solution" do
      it "returns the expected accumulator value" do
        file_path = File.join(__DIR__, "..", "data", "day_08.txt")
        program = Program.new(file_path)
        expect_raises(Program::InfiniteLoop) do
          program.execute
        end
        program.accumulator.should eq 1801
      end
    end
  end

  describe "problem 2" do
    describe "example 2" do
      it "returns the expected accumulator value" do
        file_path = File.join(__DIR__, "data", "day_08_example1.txt")
        program = Program.new(file_path)
        expect_raises(Program::InfiniteLoop) do
          program.execute
        end

        program.fix_infinite_loop.should eq true
        program.accumulator.should eq 8
      end
    end

    describe "solution" do
      it "returns the expected accumulator value" do
        file_path = File.join(__DIR__, "..", "data", "day_08.txt")
        program = Program.new(file_path)
        expect_raises(Program::InfiniteLoop) do
          program.execute
        end

        program.fix_infinite_loop.should eq true
        program.accumulator.should eq 2060
      end
    end
  end
end
