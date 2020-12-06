def fields
  @fields = %i(byr iyr eyr hgt hcl ecl pid)
end

def required_fields
  @required_fields ||= fields.map do |field|
    { field: field, validate: -> (value) { self.send("#{field}_valid?", value) } }
  end
end

def valid_between?(value, min, max)
  return false unless valid_number?(value)

  value.to_i.between?(min, max)
end

def valid_number?(value)
  true if Float(value) rescue false
end

def valid_year?(value)
  valid_number?(value) && value.size == 4
end

def byr_valid?(value)
  valid_year?(value) && valid_between?(value, 1920, 2002)
end

def ecl_valid?(value)
  %w(amb blu brn gry grn hzl oth).include?(value)
end

def eyr_valid?(value)
  valid_year?(value) && valid_between?(value, 2020, 2030)
end

def hcl_valid?(value)
  value.match?(/[#][0-9a-f]{6}/)
end

def hgt_valid?(value)
  unit = value.sub(/\d+/, "")
  return false unless %w(cm in).include?(unit)

  height = value.sub(/\D{2}/, "")

  valid_number?(height) &&
    unit == "cm" ? valid_between?(height, 150, 193) : valid_between?(height, 59, 76)
end

def iyr_valid?(value)
  valid_year?(value) && valid_between?(value, 2010, 2020)
end

def pid_valid?(value)
  value.length == 9 && valid_number?(value)
end

def input
  @input ||= File.readlines("input/4.txt", chomp: true)
end

def passports
  @passports ||= input.slice_when { |b, a| a.empty? || b.empty? }
                      .to_a
                      .map { |line| line.join(" ") }
                      .reject(&:empty?)
                      .map(&:split)
                      .map { |p| p.map { |p| p.split(":") }.to_h }
                      .map { |p| p.transform_keys(&:to_sym) }
end

part_one = 0
part_two = 0

passports.each do |passport|
  part_one += 1 if required_fields.all? { |rf| passport.include?(rf[:field]) }

  part_two += 1 if required_fields.all? do |rf|
    passport.include?(rf[:field]) &&
      rf[:validate].call(passport[rf[:field]])
  end
end

p "Part One: #{part_one}"
p "Part Two: #{part_two}"
