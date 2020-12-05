def count_trees(slope)
  trees, point = 0, 0

  (1...map.length).step(slope[:down]).each do |line|
    next_point = point + slope[:right]
    point = next_point >= max_len ? next_point - max_len : next_point

    trees += 1 if tree?(line, point)
  end

  trees
end

def hit_the_slope(slope)
  trees = count_trees(slope)

  slope_trees << trees

  output_count(slope, trees)
end

def map
  @map ||= File.readlines("input/3.txt").map(&:chomp)
end

def max_len
  @max_len ||= map[0].length
end

def multiply_trees
  slope_trees.reduce(&:*)
end

def output_count(slope, trees)
  puts "Slope: #{slope} - Trees: #{trees}"
end

def output_product
  puts "Trees (product): #{multiply_trees}"
end

def start
  slopes.each { |slope| hit_the_slope(slope) }

  output_product
end

def slope_trees
  @slope_trees ||= []
end

def slopes
  [
    { right: 1, down: 1 },
    { right: 3, down: 1 },
    { right: 5, down: 1 },
    { right: 7, down: 1 },
    { right: 1, down: 2 }
  ]
end

def tree?(line, point)
  map[line][point] == "#"
end

start
