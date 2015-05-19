# provides a way of sequentially accessing the elements of an aggregate object without exposing its underlying representation

# External iterator

class ArrayIterator
    def initialize(array)
        @array = Array.new(array)
        @index = 0
    end

    def has_next?
        @index < @array.length
    end

    def item
        @array[@index]
    end

    def next_item
        value = item
        @index += 1
        value
    end
end

it = ArrayIterator.new([1, 2, 3, 4, 5, 6])

while it.has_next?
    puts "Item #{it.next_item}"
end

