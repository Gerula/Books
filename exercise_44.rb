class Animal
	def speak
		puts "Groh gah groh"
	end
end

class Human < Animal
	def speak
		super
		puts "I am human"
	end
end

class AssHole < Human
	def speak
		super
		puts "Fuck off!"
	end
end

puts AssHole.new.speak
puts Human.new.speak
puts Animal.new.speak
