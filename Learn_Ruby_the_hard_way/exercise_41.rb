class Animal
	def initialize(name)
		@name = name
	end

	attr_reader :name
end

class Dog < Animal
end

class Cat < Animal
end

class Human < Animal
	def initialize(name, pet)
		super(name)
		@pet = pet
	end
	
	attr_accessor :pet
end

puts Dog.new("Fido").inspect
puts Dog.new("Spot").is_a?(Animal)
puts Dog.new("Spot").is_a?(Dog)

puts Human.new("Gerula", Dog.new("Voitis")).pet.name
