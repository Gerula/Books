hash = {"name" => "Art", 
	"surname" => "Vandelay",
	"weight" => 230,
	'favJoke' => "YoMomma"}

hash_ = {name: "Art",
	 surname: "Pennypacker"}

puts hash_[:name]
puts hash["favJoke"], "\n" # it's case sensitive

hash[:test] = :hashtest
puts hash[:test]
hash[:test] = :hashtest

states = {
		"Oregon" => "OR",
		"Washington" => "WA",
		"Florida" => "FL",
		"Idaho" => "ID"
	 }

cities = {
		"OR" => "Portlandia",
		"WA" => "Concrete",
		"FL" => "FloridaMan",
		"ID" => "Boise"
	 }

states.each do |state, abbrev|
	puts "#{state} is abbreviated as #{abbrev}"
end

if !states["texas"]
	puts "No Texas"
end

arkansas = states["Arkansas"] || "No Arkansas"
puts arkansas
