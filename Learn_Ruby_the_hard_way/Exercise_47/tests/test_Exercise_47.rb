require "./lib/game.rb"
require "test/unit"

class TestGame < Test::Unit::TestCase
	def test_room()
		gold = Room.new("Gold room",
				"This is gold here")
		
		assert_equal("Gold room", gold.name)
		assert_equal({}, gold.paths)
	end

	def test_paths()
		boom_boom_room = Room.new("Boom boom room",
					  "Boom!")
		boom_boom_room.add_path({"Boom" => "Bang. Now i'm in some sort of government list"})
		boom_boom_room.add_path({"Left" => "Boom"})
		
		assert_equal("Boom", boom_boom_room.go("Left"))
	end

	def test_map_e2e()
		boys_room = Room.new("Toilet",
				     "I poop in there")
		bed_room = Room.new("Bedroom",
				    "I sleep in there")
		living_room = Room.new("Living room",
				       "I live in there")

		boys_room.add_path({"west" => bed_room})
		bed_room.add_path({"north" => living_room})
		living_room.add_path({"south" => boys_room})
		
		assert_equal(boys_room, boys_room.go("west").go("north").go("south"))
	end
end
