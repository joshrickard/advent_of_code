# https://adventofcode.com/2020/day/4

class Passport
  private getter attributes : Hash(String, String)

  REQUIRED_ATTRIBUTES = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

  def initialize(data : Array(String))
    @attributes = Hash(String, String).new
    data.each do |attr_pair|
      key, value = attr_pair.split(":")
      attributes[key] = value
    end
  end

  def attributes_present? : Bool
    REQUIRED_ATTRIBUTES.all? { |attr| attributes.has_key?(attr) }
  end

  def attributes_valid? : Bool
    birth_year_valid? &&
      issue_year_valid? &&
      expiration_year_valid? &&
      height_valid? &&
      hair_color_valid? &&
      eye_color_valid? &&
      passport_id_valid?
  end

  def birth_year_valid? : Bool
    value = attributes["byr"].to_i
    value >= 1920 && value <= 2002
  end

  def expiration_year_valid? : Bool
    value = attributes["eyr"].to_i
    value >= 2020 && value <= 2030
  end

  def eye_color_valid? : Bool
    ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].includes?(attributes["ecl"])
  end

  def hair_color_valid? : Bool
    /\A#[0-9a-f]{6}\z/.matches?(attributes["hcl"])
  end

  def height_valid? : Bool
    matches = /\A(?<quantity>\d+)(?<units>cm|in)\z/.match(attributes["hgt"])
    if matches.nil?
      false
    else
      quantity = matches["quantity"].to_i
      case matches["units"]
      when "cm"
        quantity >= 150 && quantity <= 193
      when "in"
        quantity >= 59 && quantity <= 76
      else
        false
      end
    end
  end

  def issue_year_valid? : Bool
    value = attributes["iyr"].to_i
    value >= 2010 && value <= 2020
  end

  def passport_id_valid? : Bool
    /\A\d{9}\z/.matches?(attributes["pid"])
  end

  def valid? : Bool
    attributes_present? && attributes_valid?
  end
end

problem1_valid = 0
problem2_valid = 0
File.read(File.join(__DIR__, "..", "data", "day_04.txt")).split("\n\n").each do |credentials|
  credentials = credentials.split("\n").join(" ").split(" ").reject { |x| x == "" }
  passport = Passport.new(credentials)
  problem1_valid += 1 if passport.attributes_present?
  problem2_valid += 1 if passport.valid?
end

puts problem1_valid
puts problem2_valid
