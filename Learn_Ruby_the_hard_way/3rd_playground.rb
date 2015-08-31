filename = ARGV.first
actualFile = open(filename)
puts actualFile.read
actualFile.close

filename = $stdin.gets.chomp
actualFile = open(filename)
puts actualFile.read
actualFile.close

