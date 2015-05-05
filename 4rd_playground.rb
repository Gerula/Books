filename = ARGV.first
file = open(filename, "a+") # w - write, a - append. + also for reading
puts file.read
file.write("haha\n")
file.truncate(10)
file.close
