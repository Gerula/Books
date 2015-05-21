class VariableTester
    @@class_count = 0

    def initialize
        @instance_count = 0
    end

    def increment
        @@class_count += 1
        @instance_count += 1
    end

    def to_s
        "Instance:#{@instance_count} Class:#{@@class_count}"
    end
end

[VariableTester.new, VariableTester.new, VariableTester.new].each {|x|
    x.increment
    puts x
}

