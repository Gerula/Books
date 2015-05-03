# need to learn Ruby, the UComp book is very interesting but I spend a lot of time
# trying to figure out all the Ruby wizardry.

# This for exercises from Zed's book

puts "yeah, I know how to print a string"

# addition
puts 3+5
# addition with formatting
puts "3 + 5 = #{3+5}"
# modulo
puts 3 % 4
# comparison
puts "Is 5 larger than 3? #{5>3}"
# floating point
puts 2.001
puts 2.001 * 2

city   = "Seattle"
people = 1000000.0
cars   = 700000.0
roads  = 100

puts "The city of #{city} has #{people} and #{cars} for #{roads}"
puts "That's #{cars / people} cars per each person"

my_name = "Gerula"
my_weight = 230
my_height = 6

puts "Hello, my name is #{my_name}, my height is #{my_height} feet and my I weigh in at #{my_weight}"
puts "That's #{my_weight / 2.0} in kilograms and #{my_height * 30 / 100.0} in meters"

name_city = city + " " + my_name
name_city_ = 'This is a string without 2xquotes: #{name_city}' # formatting doesn't work for single quotes
puts name_city_
name_city_ = "This is a string without 2xquotes: #{name_city}"
puts name_city_
puts name_city
