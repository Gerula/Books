require "test/unit"
Dir["./*.rb"].each {|file| require file}

class Report_test < Test::Unit::TestCase
    def test_report
       report = Report.new
       assert_equal("Monthly report", report.title)
       assert_equal(["Things are going","straight to shit"], report.text)
       assert_raises(NotImplementedError) do
            report.output_report
       end
    end
end
