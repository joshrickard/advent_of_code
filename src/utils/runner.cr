require "benchmark"
require "colorize"

module Utils
  class Runner
    def self.run(problem, input_path)
      input = IO::Memory.new(File.open(input_path) { |f| f.gets_to_end })

      result = nil
      elapsed = Benchmark.measure { result = problem.run(input) }.real

      puts
      print "#{problem} -> Result: "
      print "#{result}".colorize.fore(:white).underline
      print " Took: #{elapsed * 1000}ms"
      puts
    end
  end
end
