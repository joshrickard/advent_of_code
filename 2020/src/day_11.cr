require "./data"

enum Direction
  N  # North
  NE # North East
  E  # ...
  SE
  S
  SW
  W
  NW
end

enum TileState
  EMPTY
  FLOOR
  OCCUPIED
end

alias Point = NamedTuple(x: Int32, y: Int32)

class SeatLayoutParser
  CHAR_TO_ENUM = {
    '.' => TileState::FLOOR,
    '#' => TileState::OCCUPIED,
    'L' => TileState::EMPTY,
  }

  ENUM_TO_CHAR = CHAR_TO_ENUM.invert

  def self.parse(file_path : String, layout_type)
    tile_states = Array(Array(TileState)).new

    File.each_line(file_path) do |line|
      tile_states << line.chars.map do |char|
        CHAR_TO_ENUM.fetch(char) { raise "unhandled tile char: '#{char}'" }
      end
    end

    layout_type.new(tile_states)
  end
end

abstract class SeatLayout
  private getter height : Int32
  private getter tile_states : Array(Array(TileState))
  private getter width : Int32

  DELTAS_BY_DIRECTION = {
    Direction::N  => {x: 0, y: -1},
    Direction::NE => {x: 1, y: -1},
    Direction::E  => {x: 1, y: 0},
    Direction::SE => {x: 1, y: 1},
    Direction::S  => {x: 0, y: 1},
    Direction::SW => {x: -1, y: 1},
    Direction::W  => {x: -1, y: 0},
    Direction::NW => {x: -1, y: -1},
  }

  def initialize(@tile_states)
    @height = @tile_states.size
    @width = @tile_states.first.size
  end

  def_clone

  abstract def nearby_seats_empty?(p : Point) : Bool
  abstract def nearby_seats_occupied(p : Point) : Int32
  abstract def occupied_seat_tolerance : Int32

  def each_tile_state(&b)
    tile_states.each_with_index do |row, y|
      row.each_with_index do |tile_state, x|
        yield({x: x, y: y}, tile_state)
      end
    end
  end

  def get_tile_state(p : Point) : TileState
    tile_states[p[:y]][p[:x]]
  end

  def invalid?(p : Point) : Bool
    !valid?(p)
  end

  def occupied_seats_count : Int32
    count = 0
    each_tile_state do |_, tile_state|
      count += 1 if tile_state.occupied?
    end
    count
  end

  def set_tile_state(p : Point, tile_state : TileState) : Nil
    tile_states[p[:y]][p[:x]] = tile_state
  end

  def to_s
    tile_states.map do |row|
      row.map do |col|
        SeatLayoutParser::ENUM_TO_CHAR.fetch(col) { raise "unhandled tile state: '#{col}'" }
      end.join
    end.join("\n")
  end

  def valid?(p : Point) : Bool
    p[:x] >= 0 && p[:x] < width && p[:y] >= 0 && p[:y] < height
  end
end

class AdjacentSeatLayout < SeatLayout
  def nearby_seats_empty?(p : Point) : Bool
    # Check surrounding tile states
    DELTAS_BY_DIRECTION.keys.all? do |direction|
      delta = DELTAS_BY_DIRECTION[direction]
      adjacent_point = {x: p[:x] + delta[:x], y: p[:y] + delta[:y]}
      invalid?(adjacent_point) || !get_tile_state(adjacent_point).occupied?
    end
  end

  def nearby_seats_occupied(p : Point) : Int32
    # Check surrounding tile states
    DELTAS_BY_DIRECTION.keys.count do |direction|
      delta = DELTAS_BY_DIRECTION[direction]
      adjacent_point = {x: p[:x] + delta[:x], y: p[:y] + delta[:y]}
      valid?(adjacent_point) && get_tile_state(adjacent_point).occupied?
    end
  end

  def occupied_seat_tolerance : Int32
    4
  end
end

class VisibleSeatLayout < SeatLayout
  def nearby_seats_empty?(p : Point) : Bool
    DELTAS_BY_DIRECTION.keys.all? do |direction|
      empty = true

      projected_tile_states(p, direction) do |visible_point, tile_state|
        empty = false if tile_state.occupied?

        break if tile_state.empty? || tile_state.occupied?
      end

      empty
    end
  end

  def nearby_seats_occupied(p : Point) : Int32
    DELTAS_BY_DIRECTION.keys.count do |direction|
      occupied = false

      projected_tile_states(p, direction) do |visible_point, tile_state|
        occupied = true if tile_state.occupied?

        break if tile_state.empty? || tile_state.occupied?
      end

      occupied
    end
  end

  def occupied_seat_tolerance : Int32
    5
  end

  def projected_tile_states(from : Point, direction : Direction, &b)
    delta = DELTAS_BY_DIRECTION[direction]
    i = 1
    loop do
      visible_point = {x: from[:x] + delta[:x] * i, y: from[:y] + delta[:y] * i}

      break if invalid?(visible_point)

      yield(visible_point, get_tile_state(visible_point))

      i += 1
    end
  end
end

class SeatingSimulator
  def self.simulate(layout : SeatLayout) : Tuple(Int32, SeatLayout)
    changed_tiles = 0
    next_layout = layout.clone

    layout.each_tile_state do |p, tile_state|
      if tile_state.empty? && layout.nearby_seats_empty?(p)
        next_layout.set_tile_state(p, TileState::OCCUPIED)
        changed_tiles += 1
      elsif tile_state.occupied? && layout.nearby_seats_occupied(p) >= layout.occupied_seat_tolerance
        next_layout.set_tile_state(p, TileState::EMPTY)
        changed_tiles += 1
      else
        next_layout.set_tile_state(p, tile_state)
      end
    end

    {changed_tiles, next_layout}
  end

  def self.simulate_until_stable(layout : SeatLayout) : SeatLayout
    loop do
      changed_tiles, layout = simulate(layout)

      break if changed_tiles.zero?
    end

    layout
  end
end
