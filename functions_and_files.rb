def print(file)
	puts file.read
end

def rewind(file)
	file.seek(0)
end

def print_at_offset(file, offset)
	file.seek(offset)
	puts "%{file}--%{off}: %{gets}" % {file: File.basename(file), off:offset, gets:file.gets}
end

file = open("functions_and_files.rb")
print(file)
print_at_offset(file,0)
print_at_offset(file,100)
print_at_offset(file,50)
print_at_offset(file,20)

rewind file
puts file.gets
