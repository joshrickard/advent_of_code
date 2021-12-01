require "../../2021/src/*"

p! ARGV

if ARGV.size < 3
  puts "usage: runner <year> <day> <part>"
  exit
end

p! "Year#{ARGV[0]}::Day#{ARGV[1]}::Part#{ARGV[2]}.run"
