template, copy = ARGV.first(2)
puts "Copying #{template} to #{copy}..."

open(copy, "w") do |f| # using block for added robustness\badassery
	f.write(open(template).read)
end

puts "Done. One liner. haha"
