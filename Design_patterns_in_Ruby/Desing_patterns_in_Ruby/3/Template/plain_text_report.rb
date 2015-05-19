require_relative "report"

class Plain_text_report < Report
    def output_start
        puts "--- Start report ---"
    end

    def output_head
        puts "Title: #{@title}"
    end

    def output_body_start
        puts
    end

    def output_body
        @text.each {|line|
            puts line
        }
    end

    def output_body_end
        puts 
    end

    def output_end
        puts "--- End report ---"
    end

end

Plain_text_report.new.output_report
