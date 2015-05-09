class Room
	def initialize(name, description)
	       	@name = name
		@description = description
		@paths = {}
	end

	attr_reader :name
	attr_reader :description
	attr_reader :paths

	def go(direction)
		@paths[direction]
	end

	def add_path(path)
		@paths.merge!(path)
	end
end

