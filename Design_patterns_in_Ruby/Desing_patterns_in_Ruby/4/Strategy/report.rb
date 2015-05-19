html_formatter = lambda do |report|
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

text_formatter = lambda do |report|
    puts "--- Begin report ---"
    puts " Title #{report.title}"
    report.text.each { |x|
        puts x
    }
end

class Report
    def initialize(formatter, title, text)
        @formatter = formatter
        @title = title
        @text = text
    end

    def print
        @formatter.call(self)
    end

    attr_accessor :formatter
    attr_reader :title
    attr_reader :text
end

report = Report.new(text_formatter, "Status", ["Everything sucks", "badly"])
report.print
report.formatter = html_formatter
report.print

var = "nothing"

hello = lambda do
    var = "something"
    puts "Inside lambda"
end
puts var

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



