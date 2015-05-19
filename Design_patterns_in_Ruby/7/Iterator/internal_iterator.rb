class UberArray
    def initialize(array)
        @array = array
    end

    def each
        i = 0
        while i < @array.length
            yield @array[i]
            i += 1
        end
    end
end

UberArray.new([1, 2, 3, 4, 5, 6]).each do |x|
    puts "element #{x}"
end
