require "./lib/game.rb"
require "test/unit"

class TestGame < Test::Unit::TestCase
	def test_room()
		gold = Room.new("Gold room",
				"This is gold here")
		assert_equal("Gold room", gold.name)
		assert_equal({}, gold.paths)
	end
end
