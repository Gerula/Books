class Formatter
    def output_report(title, text)
        raise NotImplementedError, "Not implemented"
    end
end

class Html_formatter < Formatter
    def output_report(title, text)
        puts "<html>"
        puts "  <head>"
        puts "      <title>#{title}</title>"
        puts "  </head>"
        puts "  <body>"
        text.each { |x|
            puts "      <p> #{x} </p>"
        }

        puts "  </body>"
        puts "</html>"
    end
end

class Text_formatter < Formatter
    def output_report(title, text)
        puts "--- Begin report ---"
        puts " Title #{title}"
        text.each { |x|
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

    def print
        @formatter.output_report(@title, @text)
    end

    attr_accessor :formatter
end

report = Report.new(Text_formatter.new, "Status", ["Everything sucks", "badly"])
report.print
report.formatter = Html_formatter.new
report.print
