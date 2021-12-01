module Day12
  enum Direction
    N
    E
    S
    W
    L
    R
    F
  end

  alias Movement = NamedTuple(direction: Direction, amount: Int32)
  alias Point = NamedTuple(x: Int32, y: Int32)

  class MovementParser
    def self.parse(file_path : String) : Array(Movement)
      movements = Array(Movement).new

      File.each_line(file_path) do |line|
        direction, amount = line[0], line[1..]

        movements << {direction: Direction.parse(direction.to_s), amount: amount.to_i}
      end

      movements
    end
  end

  class Ship
    getter angle : Int32
    private setter angle : Int32
    getter position : Point
    private setter position : Point

    def initialize(@angle = 90, @position = {x: 0, y: 0})
    end

    def manhattan_distance : Int32
      position[:x].abs + position[:y].abs
    end

    def move(movement : Movement)
      direction, amount = movement[:direction], movement[:amount]
      if direction.n? || (direction.f? && angle == 0)
        self.position = {x: position[:x], y: position[:y] + amount}
      elsif direction.e? || (direction.f? && angle == 90)
        self.position = {x: position[:x] + amount, y: position[:y]}
      elsif direction.s? || (direction.f? && angle == 180)
        self.position = {x: position[:x], y: position[:y] - amount}
      elsif direction.w? || (direction.f? && angle == 270)
        self.position = {x: position[:x] - amount, y: position[:y]}
      elsif direction.l?
        self.angle = (self.angle + (360 - amount)) % 360
      elsif direction.r?
        self.angle = (self.angle + amount) % 360
      else
        raise "unhandled movement: #{movement}"
      end
    end

    def move(movement : Movement, waypoint : Point) : Point
      direction, amount = movement[:direction], movement[:amount]
      case direction
      when Direction::N
        waypoint = {x: waypoint[:x], y: waypoint[:y] + amount}
      when Direction::E
        waypoint = {x: waypoint[:x] + amount, y: waypoint[:y]}
      when Direction::S
        waypoint = {x: waypoint[:x], y: waypoint[:y] - amount}
      when Direction::W
        waypoint = {x: waypoint[:x] - amount, y: waypoint[:y]}
      when Direction::L
        sin = Math.sin(amount * Math::PI/180.0)
        cos = Math.cos(amount * Math::PI/180.0)

        waypoint = {
          x: (waypoint[:x] * cos - waypoint[:y] * sin).round.to_i,
          y: (waypoint[:x] * sin + waypoint[:y] * cos).round.to_i,
        }
      when Direction::R
        sin = Math.sin(-amount * Math::PI/180.0)
        cos = Math.cos(-amount * Math::PI/180.0)

        waypoint = {
          x: (waypoint[:x] * cos - waypoint[:y] * sin).round.to_i,
          y: (waypoint[:x] * sin + waypoint[:y] * cos).round.to_i,
        }
      when Direction::F
        self.position = {x: position[:x] + (amount * waypoint[:x]), y: position[:y] + (amount * waypoint[:y])}
      else
        raise "unhandled movement: #{movement}"
      end

      waypoint
    end
  end

  class Navigator
    private getter movements : Array(Movement)
    getter ship : Ship

    def initialize(@ship : Ship, @movements : Array(Movement))
    end

    def sail
      movements.each do |movement|
        ship.move(movement)
      end
    end

    def sail(waypoint : Point)
      movements.each do |movement|
        waypoint = ship.move(movement, waypoint)
      end
    end
  end
end
