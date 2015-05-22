class CPU
end

class SlowCpu < CPU
end

class FastCpu < CPU
end

class MotherBoard
    attr_accessor :cpu
    attr_accessor :memory_size

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

class Computer
    attr_accessor :display
    attr_accessor :motherboard
    attr_reader :drives

    def initialize(display = :crt, motherboard = MotherBoard.new, drives = [])
        @display = display
        @motherboard = motherboard
        @drives = drives
    end
end

class ComputerBuilder
    attr_reader :computer

    def initialize
        @computer = Computer.new
    end

    def turbo(turbucpu = true)
        @computer.motherboard.cpu = FastCpu.new   
    end

    def display=(display)
        @computer.display = display
    end

    def memory_size=(memory_size)
        @computer.motherboard.memory_size = memory_size
    end

    def add_dvd(writer=false)
        @computer.drives << Drive.new(:dvd, 4000000, writer)
    end

    def add_hdd(size)
        @computer.drives << Drive.new(:hdd, size, true)
    end
end

# build a rocketship

puts Computer.new(:lcd,
             MotherBoard.new(FastCpu.new, 8000000),
             [Drive.new(:fast, 10000000, true), Drive.new(:fast, 10000000, true), Drive.new(:fast, 10000000, true), Drive.new(:fast, 10000000, true)])
    .inspect  

builder = ComputerBuilder.new
builder.turbo
builder.display = :lcd
builder.memory_size = 10000000000
builder.add_dvd(true)
builder.add_hdd(10000000)
puts builder.computer.inspect
