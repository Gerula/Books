require_relative "report"

#testing private email

class Html_report < Report
    def output_start
        puts "<html>"
    end

    def output_head
        puts "  <head><title>#{@title}</title></head>"
    end

    def output_body_start
        puts "  <body>"
    end

    def output_body
        @text.each {|line|
            puts "          <p> #{line} </p>"
        }
    end

    def output_body_end
        puts "  </body>"
    end

    def output_end
        puts "</html>"
    end
end

Html_report.new.output_report
