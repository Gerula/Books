# flow

multiply = -> x, y { x * y }

puts multiply[2,5]

negative = -> x { -x }

puts negative[1]

puts multiply [ negative [1], 5 ]

number_to_letters =
	-> x {
	case x 
	when 1
		"one"
	when 2
		"two"
	else
		"whatever"
	end
	}

puts number_to_letters[2]
puts number_to_letters[3]

