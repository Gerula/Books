def variable_args(*args)
	arg1, arg2 = args
	"First #{arg1} second #{arg2}"
end

def two_args(arg1, arg2)
	"First #{arg1} second #{arg2}"
end

def no_arg5
	"no args"
end

puts no_arg5
puts two_args("one", "two")
puts variable_args("one")
puts variable_args("two", "three")
