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

    def print
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
