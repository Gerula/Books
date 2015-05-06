module Math_Stuffs
	
	def Math_Stuffs.add(a, b)
		puts "Adding #{a} and #{b}"
		a + b
	end

	def Math_Stuffs.multiply(a, b)
		puts "Adding #{a} to itself #{b} times"
		result = 0
		b.times do
			result+=a
		end
		
		result
	end
end

