# https://adventofcode.com/2020/day/7

alias Bag = NamedTuple(color: BagColor)
alias BagWithQuantity = NamedTuple(color: BagColor, quantity: Int32)
alias BagColor = String

class BagRequirement
  private getter bag_with_quantity : BagWithQuantity

  def initialize(@bag_with_quantity : BagWithQuantity)
  end

  def containable?(bag : Bag) : Bool
    bag[:color] == color
  end

  def bag
    {color: color}
  end

  def color
    bag_with_quantity[:color]
  end

  def quantity
    bag_with_quantity[:quantity]
  end
end

class Luggage
  getter bags : Hash(BagColor, Array(BagRequirement))

  def initialize(file_path : String)
    @bags = Hash(BagColor, Array(BagRequirement)).new
    File.each_line(file_path) do |line|
      color, requirements = line.chomp(".").split(" bags contain ")
      requirements.split(",").map { |r| r.chomp("bags").chomp("bag").strip }.each do |rule|
        bags[color] ||= Array(BagRequirement).new
        if rule != "no other"
          matches = /\A(?<quantity>\d+) (?<color>.+)\z/.match(rule)
          raise "unmatched rule: #{rule}" if matches.nil?
          bags[color] << BagRequirement.new({color: matches["color"], quantity: matches["quantity"].to_i})
        end
      end
    end
  end

  def inner_bag_count(bag : Bag) : Int32
    requirements = bags[bag[:color]]
    if requirements.empty?
      0
    else
      requirements.map do |r|
        r.quantity + r.quantity * inner_bag_count(r.bag)
      end.sum
    end
  end

  def packing_options(bag_to_store : Bag, current_path : Array(Bag), requirements : Array(BagRequirement), options : Array(Array(Bag))) : Nil
    return if requirements.empty?

    requirements.each do |requirement|
      requirement_bag = {color: requirement.color}
      if requirement.containable?(bag_to_store)
        options << (current_path + [requirement_bag])
      end

      packing_options(
        bag_to_store: bag_to_store,
        current_path: current_path + [requirement_bag],
        requirements: bags[requirement.color],
        options: options
      )
    end
  end

  def top_level_bag_color_options(bag_to_store : Bag)
    options = Array(Array(Bag)).new

    bags.each do |color, requirements|
      packing_options(
        bag_to_store: bag_to_store,
        current_path: [{color: color}],
        requirements: requirements,
        options: options,
      )
    end

    options.map { |option| option.first }.uniq
  end
end
