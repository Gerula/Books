arr = [] # pirate array. hahah

ten_things = "one two three four little endians"
print ten_things, "\n"
ten_things = ten_things.split(" ")
print ten_things, "\n"
arr << "0"
arr << 1
arr << "Crocodile"

print arr, "\n"
arr << ten_things
arr << -9
print arr, "\n"
puts arr[0]
puts arr[2]
puts arr[-1] # this right here is why we can't have nice things
print arr[0..2], "\n"
print arr.join("$$"), "\n" # apparently join is called recursively
print arr.flatten!, "\n" # nice ! means do it on the same array and return nil if nothing happened
