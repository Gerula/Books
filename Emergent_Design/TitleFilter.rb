# So this is the one in which you have an if statement which you replace with an object oriented mechanism
# The saying goes that OOP structure would replace procedural code logic.
# The marketing pitch is that this makes you write less code. Less code -> less bugs - or something.
#
# The book says that such a pseudocode:
#
# - do some stuff
# - if stuff is in a certain way
# -	then do this
# - carry on doing other stuff
#
# For example you have a mechanism which gets book titles from a library. Easy enough. But then if you are displaying it in a mobile UI (or whatever) you need to filter the first ten. What do you do?
# You allegedly use a Decorator.
#

Struct.new("Book", :title, :author)
$books = [Struct::Book.new("Emergent Design", "Scott Bain")]
$books += [Struct::Book.new("Ermagerd Design", "Scott Bain")]
$books += [Struct::Book.new("Emergen Design", "Scott Bain")]
$books += [Struct::Book.new("Egent Design", "Scott Bain")]
$books += [Struct::Book.new("xoxoxoxo Design", "Scott Bain")]
$books += [Struct::Book.new("Forth Design", "Scott Bain")]

class TitleExtractor
	def extract_titles()
		raise("Please don't use this directly. It's just bad Karma")
	end
end



TitleExtractor.new.extract_titles
