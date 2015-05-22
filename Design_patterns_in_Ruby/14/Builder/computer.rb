class Computer
    attr_reader :display
    attr_reader :motherboard
    attr_reader :drives

    def initialize(display = :crt, motherboard = Motherboard.new, drives = [])
        @display = display
        @motherboard = motherboard
        @drives = drives
    end
end

class CPU
end

class SlowCpu < CPU
end

class FastCpu < CPU
end

class MotherBoard
    attr_reader :cpu
    attr_reader :memory_size

    def initialize(cpu = SlowCpu.new, memory_size = 1024)
        @cpu = cpu
        @memory_size = memory_size
    end
end

class Drive
    attr_reader :type
    attr_reader :size
    attr_reader :writable

    def initialize(type, size, writable)
        @type = type
        @size = size
        @writable = writable
    end
end

# build a rocketship

puts Computer.new(:lcd,
             MotherBoard.new(FastCpu.new, 8000000),
             [Drive.new(:fast, 10000000, true), Drive.new(:fast, 10000000, true), Drive.new(:fast, 10000000, true), Drive.new(:fast, 10000000, true)])
    .inspect  
