puts 10.class
puts 10.instance_of?(Fixnum)
puts 10.instance_of?(Bignum)
puts 1000000000000000000000000000000000000000000.class
puts 1000000000000000000000000000000000000000000.instance_of?(Bignum)
puts 1000000000000000000000000000000000000000000.instance_of?(Fixnum)

puts nil.class

if 0
    puts "Where is your God now?"
end

puts "What?".upcase
puts "What?".downcase

puts "What?" == "WHAT?"
puts "What?".upcase == "WHAT?".upcase

"What"[0] = 'x' #lol

s = "Doodle"
s[0] = "Miii"
puts s

puts :a_symbol.class
puts :a_symbol

# yay regex

puts "Match" if /^x$/ =~ "x"
