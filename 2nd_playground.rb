# The first one is getting big so created another one.
# Don't really know or care on how to organize this crap.

first, second, third = ARGV
user = ARGV.first
prompt = "$> "

puts "First #{first}"
puts "Second #{second}"
puts "Third #{third}"

puts ARGV.inspect

print "username ", prompt
username = $stdin.gets.chomp # apparently if you use ARGV you need to explicitly specify $stdin
			     # as it will default to ARGV.first otherwise
puts "Username:#{username}"
