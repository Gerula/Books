class Html_formatter
    def output_report(report)
        puts "<html>"
        puts "  <head>"
        puts "      <title>#{report.title}</title>"
        puts "  </head>"
        puts "  <body>"
        report.text.each { |x|
            puts "      <p> #{x} </p>"
        }

        puts "  </body>"
        puts "</html>"
    end
end

class Text_formatter
    def output_report(report)
        puts "--- Begin report ---"
        puts " Title #{report.title}"
        report.text.each { |x|
            puts x
        }
   end
end

class Report
    def initialize(formatter, title, text)
        @formatter = formatter
        @title = title
        @text = text
    end

    def print(code = nil)
        code.call unless code == nil
        @formatter.output_report(self)
    end

    attr_accessor :formatter
    attr_reader :title
    attr_reader :text
end

report = Report.new(Text_formatter.new, "Status", ["Everything sucks", "badly"])
report.print
report.formatter = Html_formatter.new
report.print

var = "nothing"

hello = lambda do
    var = "something"
    puts "Inside lambda"
end
puts var
report.print(hello)
puts var

report.print(lambda{ puts "what's up what's up?" })

puts lambda{ |x, y, z| x + y + z}.call(1, 2, 3)

def run_stuff
    puts "Running things"
    yield unless !block_given?
    puts "Finished running these things"
end

run_stuff {
    puts "Executing"
}

run_stuff do 
    puts "executing 2"
end



