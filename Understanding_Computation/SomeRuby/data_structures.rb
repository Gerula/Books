
# comment
# lol

array = ["zero", "one", "two"]
print array
print array.take(1)
print array.take(2)
puts array.take(2)

array.push(1)

puts array[1]
puts array

array = array.drop(2)
puts array

interval_asc = Array (1..5)
interval_desc = Array (4.downto(1))
flip_flop = interval_asc + interval_desc
puts flip_flop
puts flip_flop.include?(2)
puts flip_flop.include?(10)

number = -100
if flip_flop.include?(number)
      puts "includes " + number.to_s
   else
      puts "not includes " + number.to_s
end
