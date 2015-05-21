class Enhanced_writer
    def initialize(path)
        @file = File.open(path, "w")
        @line_number = 1
    end

    def write_line(line)
        @file.print(line)
        @file.print("\n")
    end

    def time_stamp_write_line(line)
        write_line("#{Time.new} - #{line}")
    end

    def line_number_write_line(line)
        write_line("#{@line_number} - #{line}")
        @line_number += 1
    end

    def close
        @file.close
    end
end

writer = Enhanced_writer.new("test")
writer.write_line("Enhanced_writer")
writer.time_stamp_write_line("Time stamp")
writer.line_number_write_line("line")
writer.line_number_write_line("line")
writer.close
puts File.open("test", "r").read
File.delete("test")

