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

    def self.static_method # it also works with VariableTester.static_method but self is better as if you change the class name you don't have to change this
        puts "#{self}"
    end

    def method_missing(name, *args)
        puts "WTF?"
    end
end

[VariableTester.new, VariableTester.new, VariableTester.new].each {|x|
    x.increment
    puts x
    x.static_method
}

VariableTester.static_method

