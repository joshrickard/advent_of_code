require "../utils/runner"

# https://adventofcode.com/2022/day/7

module Year2022::Day7
  abstract class FileSystemNode
    property parent : FileSystemNode?

    def initialize(@parent)
    end

    abstract def name : String
    abstract def size : Int64
  end

  class DirectoryNode < FileSystemNode
    property children : Hash(String, FileSystemNode)
    property name : String

    def initialize(@name, parent = nil)
      @children = Hash(String, FileSystemNode).new
      super(parent)
    end

    def child_directory(path_component : String) : DirectoryNode
      children[path_component].as(DirectoryNode)
    end

    def size : Int64
      total_size = 0_i64
      children.each_value do |node|
        total_size += node.size
      end
      total_size
    end
  end

  class FileNode < FileSystemNode
    property name : String
    property size : Int64

    def initialize(@name, @size, parent = nil)
      super(parent)
    end
  end

  class FileSystem
    protected property root : DirectoryNode

    def initialize
      @root = DirectoryNode.new(name: "/", parent: nil)
    end

    def find_directories(minimum_size : Int64) : Array(DirectoryNode)
      self.class.find_directories(root, minimum_size)
    end

    protected def self.find_directories(node : DirectoryNode, minimum_size : Int64) : Array(DirectoryNode)
      directories = Array(DirectoryNode).new

      node.children.each_value do |child_node|
        next unless child_node.is_a?(DirectoryNode)

        directories << child_node if child_node.size > minimum_size
        directories.concat(find_directories(child_node, minimum_size))
      end

      directories
    end

    def insert(absolute_path : Array(String), node : FileSystemNode) : Nil
      parent_node = root
      absolute_path.each_with_index do |path_component, i|
        next if i == 0

        parent_node = parent_node.child_directory(path_component)
      end

      parent_node.children[node.name] = node
      node.parent = parent_node
    end

    def directory_sum(maximum_size : Int64) : Int64
      self.class.directory_sum(root, maximum_size)
    end

    def size : Int64
      total = 0_i64

      root.children.each_value do |child_node|
        total += child_node.size
      end

      total
    end

    protected def self.directory_sum(node : DirectoryNode, maximum_size : Int64) : Int64
      total = 0_i64

      node.children.each_value do |child_node|
        next unless child_node.is_a?(DirectoryNode)

        total += child_node.size if child_node.size < maximum_size
        total += directory_sum(child_node, maximum_size)
      end

      total
    end
  end

  class TerminalOutputParser
    protected property input : IO

    def initialize(@input); end

    def file_system : FileSystem
      file_system = FileSystem.new

      current_path = Array(String).new
      previous_command = nil
      input.each_line do |line|
        if line.starts_with?("$")
          if !(match = line.match(/cd (?<path>.+)$/)).nil?
            if match["path"] == "/"
              current_path = ["/"]
            elsif match["path"] == ".."
              current_path.pop
            else
              current_path.push(match["path"])
            end

            previous_command = :cd
          elsif line == "$ ls"
            previous_command = :ls
          else
            raise "Unhandled command: '#{line}'"
          end
        else
          if previous_command == :ls
            if !(match = line.match(/^dir (?<directory>.+)$/)).nil?
              file_system.insert(current_path, DirectoryNode.new(match["directory"]))
            elsif !(match = line.match(/^(?<size>\d+) (?<file_name>.+)$/)).nil?
              size = match["size"].to_i64
              file_name = match["file_name"]

              file_system.insert(current_path, FileNode.new(file_name, size))
            end
          else
            raise "Unhandled previous command: '#{previous_command}'"
          end
        end
      end

      file_system
    end
  end

  class Part1
    def self.run(input : IO)
      file_system = TerminalOutputParser.new(input).file_system
      file_system.directory_sum(100000)
    end
  end

  class Part2
    def self.run(input : IO)
      file_system = TerminalOutputParser.new(input).file_system
      used_space = file_system.size
      free_space = 70000000 - used_space
      space_needed = 30000000 - free_space
      directories = file_system.find_directories(space_needed)
      directories.min_by(&.size).size
    end
  end
end

input_path = "#{__DIR__}/input/#{File.basename(__FILE__, ".cr")}.txt"

Utils::Runner.run(input_path, Year2022::Day7::Part1) if ARGV.size.positive? && ARGV.first == "part1"
Utils::Runner.run(input_path, Year2022::Day7::Part2) if ARGV.size.positive? && ARGV.first == "part2"
