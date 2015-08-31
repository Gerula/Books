def add(a,b)
	puts "%{a} + %{b}" % {a:a, b:b}
	return a + b
end

def substract(a,b)
	puts "%{a} - %{b}" % {a:a, b:b}
	return a - b
end

def multiply(a,b)
	puts "%{a} * %{b}" % {a:a, b:b}
	return a * b
end

puts add(1,2)
puts substract(0,100)
puts multiply(0,100)
puts add(multiply(2,3),substract(100,10))
