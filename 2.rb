policies = File.readlines("input/2.txt")
               .map(&:split)

part_one = []
part_two = []

policies.each do |policy|
  min, max = policy[0].split("-").map(&:to_i)
  pos_one, pos_two = policy[0].split("-").map { |i| i.to_i - 1 }
  letter = policy[1].chr
  password = policy[2]

  scan_size = password.scan(letter).size
  part_one << password if scan_size.between?(min, max)

  matches = [
    password[pos_one] == letter,
    password[pos_two] == letter
  ]

  part_two << password if matches.reject(&:!)
                                 .size == 1
end

puts "Part 1 Answer: #{part_one.size}"
puts "Part 2 Answer: #{part_two.size}"
