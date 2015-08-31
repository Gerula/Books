numbers = [1, 2, 3, 4, 5]
fruit = ["Apples", "Oranges", "Peaches"]
mix = [1, "Apples", 3]

for number in numbers
	puts "number: #{number}"
end

fruit.each {
	|fruit| puts "Fruit #{fruit}"
}

mix.each do |mix|
	puts "Mix #{mix}"
end

elements = []

(1..5).each do |number|
	elements << number
end

puts elements
