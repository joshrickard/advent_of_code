class Instruction
  getter lineno : Int32
  property parameter : Int32
  property type : String

  def initialize(@lineno, @parameter, @type)
  end
end

class InstructionParser
  def self.parse(file_path) : Array(Instruction)
    File.read(file_path).split("\n").map_with_index do |line, i|
      type, parameter = line.split(" ")
      Instruction.new(i + 1, parameter.to_i, type)
    end
  end
end

class Program
  class InfiniteLoop < Exception; end

  getter accumulator : Int32
  private setter accumulator : Int32
  private getter executed_instructions : Set(Int32)
  private getter instructions : Array(Instruction)

  def initialize(file_path : String, @accumulator = 0, @executed_instructions = Set(Int32).new)
    @instructions = InstructionParser.parse(file_path)
  end

  def execute
    self.accumulator = 0
    executed_instructions.clear

    i = 0
    while i < instructions.size
      raise InfiniteLoop.new("at line #{i + 1}") if executed_instructions.includes?(i)

      executed_instructions << i

      instruction = instructions[i]
      case instruction.type
      when "acc"
        self.accumulator += instruction.parameter
        i += 1
      when "jmp"
        i += instruction.parameter
      when "nop"
        i += 1
      else
        raise "unsupported instruction '#{instruction.type}'"
      end
    end

    true
  end

  def fix_infinite_loop : Bool
    mutable_instructions = Array(NamedTuple(index: Int32, old_type: String, new_type: String)).new

    instructions.each_with_index do |instruction, i|
      if instruction.type == "jmp"
        mutable_instructions << {index: i, old_type: instruction.type, new_type: "nop"}
      elsif instruction.type == "nop"
        mutable_instructions << {index: i, old_type: instruction.type, new_type: "jmp"}
      end
    end

    loop do
      return false if mutable_instructions.empty?

      instruction = mutable_instructions.pop
      instructions[instruction[:index]].type = instruction[:new_type]
      begin
        execute
        return true
      rescue InfiniteLoop
        instructions[instruction[:index]].type = instruction[:old_type]
      end
    end

    false
  end
end
