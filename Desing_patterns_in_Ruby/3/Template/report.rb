class Report
    def initialize
        @title = "Montly report"
        @text = ["Things are going", "straight to shit"]
    end

    def output_report
        output_start
        output_head
        output_body_start
        output_body
        output_body_end
        output_end
    end
    
    def output_start
        raise("not implemented")
    end

    def output_head
        raise("not implemented")
    end

    def output_body_start
    end

    def output_body
        raise("not implemented")
    end

    def output_body_end
    end

    def output_end
        raise("not implemented")
    end
end

