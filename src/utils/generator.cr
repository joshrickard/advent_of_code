require "colorize"
require "ecr"
require "file_utils"
require "http"

abstract class AdventFile
  property day_of_month : Int32
  property year : Int32

  def initialize(@day_of_month, @year)
  end

  def create : Nil
    FileUtils.mkdir_p folder_path
    if File.exists?(file_path) && prevent_overwrite?
      puts "skipping #{file_path} which already exists".colorize(:yellow)
    else
      action = File.exists?(file_path) ? "overwriting" : "creating"
      puts "#{action} #{file_path}".colorize(:green)
      File.write(file_path, to_s)
    end
  end

  def prevent_overwrite? : Bool
    true
  end
end

class InputFile < AdventFile
  property session_cookie : String

  def initialize(day_of_month, year, @session_cookie)
    super(day_of_month, year)
  end

  def prevent_overwrite? : Bool
    false
  end

  def remote_file_url : String
    "https://adventofcode.com/#{year}/day/#{day_of_month}/input"
  end

  def to_s : String
    response = HTTP::Client.get(
      url: remote_file_url,
      headers: HTTP::Headers{
        "Cookie"     => "session=#{session_cookie}",
        "User-Agent" => "github.com/joshrickard/advent_of_code josh.rickard@gmail.com",
      }
    )

    return response.body if response.status_code == 200

    raise "Failed to download input file from #{remote_file_url}. Response status code was #{response.status_code}"
  end

  private def folder_path : String
    "src/#{year}/input"
  end

  private def file_path : String
    "#{folder_path}/day_#{day_of_month}.txt"
  end
end

class SolutionFile < AdventFile
  private def folder_path : String
    "src/#{year}"
  end

  private def file_path : String
    "#{folder_path}/day_#{day_of_month}.cr"
  end

  ECR.def_to_s "#{__DIR__}/templates/solution.ecr"
end

class SpecFile < AdventFile
  private def folder_path : String
    "spec/#{year}"
  end

  private def file_path : String
    "#{folder_path}/day_#{day_of_month}_spec.cr"
  end

  ECR.def_to_s "#{__DIR__}/templates/spec.ecr"
end

# Solutions are posted at midnight eastern time
default_time = Time.local(Time::Location.load("America/New_York"))

year = (ARGV.size > 0 ? ARGV[0] : default_time.to_s("%Y")).to_i
day_of_month = (ARGV.size > 1 ? ARGV[1] : default_time.to_s("%-d")).to_i
session_cookie = File.read(".session-cookie")

InputFile.new(day_of_month, year, session_cookie).create
SolutionFile.new(day_of_month, year).create
SpecFile.new(day_of_month, year).create
