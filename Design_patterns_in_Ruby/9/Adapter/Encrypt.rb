class Encrypter
    def initialize(key)
        @key = key
    end

    def encrypt(input, output)
        i = 0
        while not input.eof?
            clean_char = input.getc
            encrypted_char = clean_char.ord ^ @key[i].ord
            output.putc(encrypted_char.chr)
            i = (i + 1) / @key.size
        end
    end
end

class StringIOAdapter
    def initialize(string)
        @string = string
        @position = 0
    end

    def eof?
        @position == @string.size
    end

    def getc
        @position += 1
        @string[@position - 1]
    end

    def putc(char)
        @string[@position] = char
        @position += 1
    end

    def to_s
        @string
    end
end

input = StringIOAdapter.new("Lateralus")
key = "key"
output = StringIOAdapter.new("")

Encrypter.new(key).encrypt(input, output)
puts output


