def variable_args(*args)
	arg1, arg2 = args
	"First #{arg1} second #{arg2}"
end

def two_args(arg1, arg2)
	"First #{arg1} second #{arg2}"
end

def no_arg5
	"no args"
end

puts no_arg5
puts two_args("one", "two")
puts variable_args("one")
puts variable_args("two", "three")

# functions need to be defined before they are used. Duuuh.. interpreter

def party(number_of_cheese, number_of_crackers)
	puts "You have #{number_of_cheese} cheese and #{number_of_crackers} crackers"
	if number_of_cheese == 0
		puts "You can't party"
	else
		puts "You can party"
	end
end

party(2 + 10, 3)

cheese = 30
crackers = cheese
party(cheese, crackers) #spacing is a bitch. Spacing after function name before ( is a nope

print "How many cheese? "
cheese = gets.chomp.to_i
party(cheese, crackers)
party(0, 1)

