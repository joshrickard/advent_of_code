# https://adventofcode.com/2020/day/6

class AnswerFile
  getter groups : Array(Group)

  def initialize(file_path : String)
    @groups = File.read(file_path).split("\n\n").map do |group_data|
      Group.new(group_data)
    end
  end
end

class Group
  private property passenger_answers : Array(String)

  def initialize(data : String)
    @passenger_answers = data.split("\n")
  end

  def common_answers : Set(Char)
    passenger_answers.map do |passenger_answer|
      Set(Char).new(passenger_answer.chars)
    end.reduce { |accumulator, a| accumulator & a }
  end

  def unique_answers : Set(Char)
    passenger_answers.each_with_object(Set(Char).new) do |passenger_answer, results|
      results.concat(passenger_answer.chars)
    end
  end
end

answer_file = AnswerFile.new(File.join(__DIR__, "data", "day_06.txt"))

puts answer_file.groups.map { |group| group.unique_answers.size }.sum
puts answer_file.groups.map { |group| group.common_answers.size }.sum
