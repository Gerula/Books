# there is no specific thing to do here so I'll just play around with the symbols

def trim(string)
	string.chomp("le")
end

s = "Middle"
puts s
puts trim(s)
alias trimm trim # Why? Who does that, really?
puts trimm(s)
puts trim(s)

BEGIN {
	puts "Hello"
	puts "This is the beginning"
}

END {
	puts "Bye bye"
	puts "Bye"
}
