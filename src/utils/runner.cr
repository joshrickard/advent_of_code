# require "../2021/*"

# p! ARGV

# if ARGV.size < 3
#   puts "usage: runner <year> <day> <part>"
#   exit
# end

# solution = "Year#{ARGV[0]}::Day#{ARGV[1]}::Part#{ARGV[2]}.run"

# macro dispatch(name, input)
#   case {{ name }}
#     {% for year in (2021..2021) %}
#       {% for day_of_month in (1..25) %}
#         {% for part in (1..2) %}
#         when "Year#{ {{ year }}}::Day#{ {{ day_of_month }} }::Part#{ {{ part }} }" then
#           Year{{ year }}::Day{{ day_of_month.id }}::Part{{ part.id }}.run({{ input }})
#         {% end %}
#       {% end %}
#     {% end %}
#   else
#     raise "Unhandled solution: #{solution_name}"
#   end
# end

# name = ""

# dispatch(name, IO::Memory.new)

# p! solutions_by_name

# p! Year2021::Day01::Part1
# {% if @top_level.has_constant?("Year2021::Day01") %}
#   puts "Year2021::Day01::Part1"
# {% else %}
#   puts "not defined Year2021::Day01::Part1"
# {% end %}
