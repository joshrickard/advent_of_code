require "benchmark"
require "colorize"

module Utils
  class Runner
    def self.run(input_path, *solutions)
      puts "Running #{solutions.size} solution(s)"

      results_by_solution = Hash(String, String).new
      Benchmark.ips do |x|
        solutions.each do |solution|
          input = IO::Memory.new(File.open(input_path) { |f| f.gets_to_end })
          solution_name = solution.name
          x.report("#{solution}") do
            input.rewind
            result = solution.run(input)
            results_by_solution[solution_name] = result.to_s
          end
        end
      end

      puts
      puts "Results"
      results_by_solution.each do |solution, result|
        print "  #{solution} => "
        print result.colorize.fore(:white).underline
        puts
      end
      puts
    end
  end
end
