class Report
    def initialize
        @title = "Monthly report"
        @text = ["Things are going", "straight to shit"]
    end

    attr_reader :title
    attr_reader :text

    def output_report
        output_start
        output_head
        output_body_start
        output_body
        output_body_end
        output_end
    end
    
    def output_start
        raise(NotImplementedError, "not implemented")
    end

    def output_head
        raise(NotImplementedError, "not implemented")
    end

    def output_body_start
    end

    def output_body
        raise(NotImplementedError, "not implemented")
    end

    def output_body_end
    end

    def output_end
        raise(NotImplementedError, "not implemented")
    end
end

