class Duck
    def initialize(name)
        @name = name
    end

    def eat
        puts("Duck #{@name} is eating")
    end

    def speak
        puts("Duck #{@name} is speaking")
    end

    def sleep
        puts("Duck #{@name} is sleeping")
    end
end

class Pond
    def initialize(number_of_ducks)
        @ducks = []
        number_of_ducks.times { |x|
            @ducks<<Duck.new("Duck#{x}")
        }
    end

    def day
        @ducks.each { |duck| duck.eat }
        @ducks.each { |duck| duck.speak}
        @ducks.each { |duck| duck.sleep}
    end
end

Pond.new(10).day
