def gold_room
	print "Ur in a room full of gold. How much do u teak?"
	choice = gets.chomp
	
	number = 0
	if Integer(number) 
		number = choice.to_i
	else
		dead("Wrong number")
	end

	if number<50
		puts "ur not greedy. good for yoo"
	else
		puts "greedy basterd, u lose"
	end
end

def bear_room
	puts "bear here"

end

def dead(why)
	puts why + " Great job!"
	exit(0)
end

gold_room
bear_room
