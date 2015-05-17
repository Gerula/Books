class Report
    def initialize
        @title = "Montly report"
        @text = ["Things are going", "straight to shit"]
    end

    def output_report
        puts "<html>"
        puts "  <head>"
        puts "      <title>#{@title}</title>"
        puts "  </head>"
        puts "  <body>"
        @text.each { |line|
            puts "      <p> #{line} </p>"
        }
        puts "  </body>"
        puts "</html>"
    end
end

Report.new.output_report
