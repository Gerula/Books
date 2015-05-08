class Animal
	def speak
		puts "Groh gah groh"
	end
end

class Human < Animal
	def initialize
		@kids = []
	end

	def speak
		puts "I am human"
	end

	def give_birth(kid)
		@kids.push(kid)
	end

	attr_accessor :kids
end

class AssHole < Human
	def speak
		puts "Fuck off!"
	end
end

puts AssHole.new.speak
puts Human.new.speak
puts Animal.new.speak
asshole = AssHole.new
asshole.give_birth(AssHole.new)
asshole.give_birth(Human.new)

asshole.kids.inspect

puts "Kids speaking now"
asshole.kids.each {|kid| kid.speak}
