class Writer_decorator
    def initialize(writer)
        @writer = writer
    end

    def write_line(line)
        @writer.write_line(line)
    end

    def pos
        @writer.pos
    end

    def rewind
        @writer.rewind
    end

    def close
        @writer.close
    end
end

class Numbering_writer < Writer_decorator
    def initialize(writer)
        super(writer)
        @line = 0
    end

    def write_line(line)
        @writer.write_line("#{@line} - #{line}")
        @line += 1
    end
end

class TimeStamp_writer < Writer_decorator
    def write_line(line)
        @writer.write_line("#{Time.new} - #{line}")
    end
end

class Simple_writer
    def initialize(path)
        @file = File.open(path, "w")
    end

    def write_line(line)
        @file.print(line)
        @file.print("\n")
    end

    def pos
        @file.pos
    end

    def rewind
        @file.rewind
    end

    def close
        @file.close
    end
end

writer = Simple_writer.new("test")
numbering = Numbering_writer.new(writer)
timing = TimeStamp_writer.new(writer)
writer.write_line("Enhanced_writer")
timing.write_line("Time stamp")
numbering.write_line("line")
numbering.write_line("line")
writer.close
puts File.open("test", "r").read
File.delete("test")

