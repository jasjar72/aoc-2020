def input
  @input ||= File.readlines("input/5.txt", chomp: true)
end

def row_chars(pass)
  pass[0..6].chars
end

def col_chars(pass)
  pass[7..9].chars
end

seats = []
spots = []

input.each do |pass|
  row_min = 0
  row_max = 127
  row = 0

  row_chars(pass).each do |rc|
    if rc == "F"
      row_max = (row_max + row_min) / 2
    else
      row_min = ((row_min + row_max) / 2) + 1
    end

    row = row_max if row_min == row_max
  end

  col_min = 0
  col_max = 7
  col = 0

  col_chars(pass).each do |cc|
    if cc == "L"
      col_max = (col_max + col_min) / 2
    else
      col_min = ((col_min + col_max) / 2) + 1
    end

    col = col_max if col_min == col_max
  end

  spots << [row, col]
  seats << row * 8 + col
end

p "Max Seat Number: #{seats.max}"

(0..127).each do |row|
  p spots.select { |s| s[0] == row }.sort_by { |s| s[1] }
end

#todo: finish this so it outputs the exact spot
