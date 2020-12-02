expense_report = File.readlines("input/1.txt")
                     .map(&:to_i)

(1..2).each do |i|
  items = expense_report.combination(i + 1)
                        .to_a
                        .select { |x| x.sum == 2020 }
                        .flatten

  puts "Part #{i}"
  puts "Answer: #{items.inject(:*)}"
  puts ""
end
