# https://adventofcode.com/2020/day/5

def search(min : Int32, max : Int32, codes : String) : Int32
  codes.chars.each do |char|
    case char
    when 'F', 'L'
      max = max - ((max - min) // 2)
    when 'B', 'R'
      min = min + ((max - min) // 2)
    else
      raise "unexpected character: #{char}"
    end
  end

  min
end

max_seat_id = 0
seat_ids = Array(Int32).new
File.each_line(File.join(__DIR__, "data", "day_05.txt")) do |code|
  row_code, col_code = code[0..-4], code[-3..-1]

  row = search(0, 128, row_code)
  col = search(0, 8, col_code)
  id = row * 8 + col

  seat_ids << id

  max_seat_id = id if id > max_seat_id
end

puts "highest seat id: #{max_seat_id}"

seat_ids.sort!

i = 1
# iterate over seats until we find a missing id
while i < seat_ids.size
  if (seat_ids[i] - 1) != seat_ids[i - 1]
    puts "missing seat: #{seat_ids[i] - 1}"
    break
  end

  i += 1
end
