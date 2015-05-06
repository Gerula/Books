numbers = []
i = 0

while i < 10
	numbers << i
	i+=1
	print numbers
	puts
end

(1..10).each do |n|
	numbers << n
	n += 10
end

print numbers
puts

def fillArray(size, increment)
	numbers = []
	i = 0
	while i < size
		numbers << i
		i += increment
	end
	
	return numbers
end

numbers = fillArray(10, 2)
print numbers

