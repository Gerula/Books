#simple intepreter

class Thing < Struct.new(:value)
	def +(other)
		Thing.new(value + other.value)
	end

	def inspect
		"thingy #{value}"
	end
end

t = Thing.new(2)+Thing.new(3)
puts t.inspect

#playing around with this struct shit first

class Number < Struct.new(:value) # what the shit is this?
	# ha found it http://thepugautomatic.com/2013/08/struct-inheritance-is-overused/
	# apparently it's a hipster thing
	# crap, maybe I shouldn't have skipped chapter 1
	def to_s
		"<#{value}>"
	end

	def reducible?
		false
	end
end

class Add < Struct.new(:left, :right)
	def to_s
		"#{left} + #{right}"
	end
	
	def reducible?
		true
	end

	def reduce(environment)
		if left.reducible?
			Add.new(left.reduce(environment), right)	
		elsif right.reducible?
			Add.new(left, right.reduce(environment))
		else
			Number.new(left.value + right.value)
		end
	end
end

class Multiply < Struct.new(:left, :right)
	def to_s
		"#{left} * #{right}"
	end
	def reducible?
		true
	end

	def reduce
		if left.reducible?
			Multiply.new(left.reduce, right)
		elsif right.reducible?
			Multiply.new(left, right.reduce)
		else
			Number.new(left.value * right.value)
		end
	end
end

print Number.new(
    Add.new(
    Multiply.new(
	     Number.new(1),
	     Number.new(2)
	     ),
    Multiply.new(
	     Number.new(3),
	     Number.new(4)
	     )
    )
    )

def reducible?(item)
   case item
   when Add, Multiply
	true
   when Number
	false
   else false	
   end	   
end

puts reducible?(Number.new(Number.new(1)))

puts reducible?(Add.new(Number.new(1),Number.new(2)))

puts Add.new(Number.new(3), Number.new(5)).reducible?

puts Add.new(
	Add.new(
		Number.new(1),
		Number.new(2)
	),
	Number.new(3)
)#.reduce

expression = Add.new(Add.new(Number.new(1), Number.new(2)), Add.new(Add.new(Number.new(4), Number.new(5)), Number.new(1)))

#while expression.reducible?
#	puts expression
#	expression = expression.reduce
#end

#puts "final #{expression}"


class Variable < Struct.new(:name)
	def to_s
		name.to_s
	end

	def inspect
		"<#{self}>"
	end

	def reducible?
		true
	end	

	def reduce(environment)
		environment[name]
	end
end

class DoNothing
	def to_s
		"nothing"
	end

	def inspect
		"#{self}"
	end

	def==(other)
		other.instance_of?(DoNothing)
	end

	def reducible?
		false
	end
end

class Assign < Struct.new(:variable, :value)
	def to_s
		"#{variable}==#{value}"
	end

	def inspect
		"#{self}"
	end

	def reducible?
		true
	end

	def reduce(environment)
		if value.reducible?
			[Assign.new(variable, value.reduce(environment)), environment]
		else
			[DoNothing.new, environment.merge({variable => value})]
		end
	end
end

statement = Assign.new(Variable.new(:x), Add.new(Variable.new(:y), Number.new(1)))
puts statement.reducible?
environment = {x: Number.new(0), y: Number.new(1)}
environment = statement.reduce(environment)
puts "Statement: #{statement}"
puts statement.reducible?

#changed names again

class Machine < Struct.new(:statement, :environment)
	def step
		self.statement, self.environment = statement.reduce(environment)
	end

	def run
		while statement.reducible?
			puts "#{statement} env #{environment}"
			step
		end
		puts "#{statement} #{environment}"
	end
end

puts Machine.new(
	Assign.new(:z,
	Add.new(
		Add.new(
			Add.new(
				Variable.new(:x),
				Number.new(2)),
			Variable.new(:y)),
		Number.new(4))),
	{
		x: Number.new(1),
		y: Number.new(3)
	}).run



