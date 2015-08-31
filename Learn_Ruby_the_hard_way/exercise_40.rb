require_relative "my_stuff"
require_relative "my_stuff_class"

puts MyStuff.apple
puts MyStuff::ORANGE
puts Stuff.new.inspect
puts Stuff.new.tangerine

class Song
	def initialize(lyrics)
		@lyrics = lyrics
	end

	def sing
		@lyrics.each do |lyric|
			puts lyric
		end
	end
end

Song.new([
	"What what",
	"in the butt",
	"what what?",
	"In the butt"
	]).sing


