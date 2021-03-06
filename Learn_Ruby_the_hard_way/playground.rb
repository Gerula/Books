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

puts "Interesting #{'thing'}"
puts "." * 10 # haaaaaa. Awesome x 10

puts ("x" + "y") * 10 #chhhhhahhaahhaa

formatter = "%{first} %{second} %{third}"

puts formatter % {
	first: 1,
	second: "haha",
	third: "chhhh"
}

puts formatter % {
	first: formatter % {
		first: "->1",
		second: "->2",
		third: "->3"
		},
	second: "2nd",
	third: "3"
}

days = "Monday\nTuesday\nWednesday\nThurs\\nday"
puts days

puts """
hahaha
ha
haha
"""
puts "ha"

#luckly I searched the web for this. It works for single quotes too

puts "1haha
2hahaha
3haha"

#apparently this is from Python and Zed recycled the chapters. Hey, it's a free book, not complaining.

# I got the escaping part, it's the same as in all languages
# so i'll do some examples from here: http://rors.org/2008/10/26/dont-escape-in-strings

puts "This is alledgedly stupid: \"Stupid\""
puts %-This is alledgedly smarter: "Stupid"- # in a nutshell, %- - is like @ in C# but that's not all it's more

puts %/This is alledgedly stupid - again/
puts %Q|This is the smartest|

puts "Holy shit, this is 2015. Does it still work? \a" #haha it does

print "What's ur name? "
#name = gets.chomp
name = ""
print "And ur age? "
#age = gets.chomp
age = ""
print "And ur fat? "
#weight = gets.chomp
weight = ""

summ = age + weight #dynamic my ass - this is string concat - you need to do gets.chomp.to_i
puts summ

puts "%{name} is %{age} years old and %{weight} fat" % {name: name, age: age, weight: weight}

print "Gimme a number"
number = gets.chomp.to_f
print "Gimme some moneys"
moneyz = gets.chomp.to_f

puts "This is #{number} percent added to ur monez: #{moneyz + number/100*moneyz}"
