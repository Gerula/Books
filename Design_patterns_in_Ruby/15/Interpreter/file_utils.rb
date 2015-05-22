require 'find'

class Expression
    def |(other)
        Or.new(self, other)
    end

    def &(other)
        And.new(self, other)
    end
end

class All < Expression
    def evaluate(dir)
        results = []
        Find.find(dir) { |x|
            next unless File.file?(x)
            results << x
        }

        return results
    end
end

class FileName < Expression
    def initialize(pattern)
        @pattern = pattern
    end
    
    def evaluate(dir)
        results = []
        Find.find(dir) { |x|
            next unless File.file?(x)
            name = File.basename(x)
            results << x if File.fnmatch(@pattern, name)
        }

        return results
    end
end

class BigFile < Expression
    def initialize(size)
        @size = size
    end
    
    def evaluate(dir)
        results = []
        Find.find(dir) { |x|
            next unless File.file?(x)
            results << x if File.size(x) > @size
        }

        return results
    end

end

class Not < Expression
    def initialize(expression)
        @expression = expression
    end

    def evaluate(dir)
        All.new.evaluate(dir) - @expression.evaluate(dir)
    end
end

class Or < Expression
    def initialize(expression1, expression2)
        @expression1 = expression1
        @expression2 = expression2
    end

    def evaluate(dir)
        @expresion1.evaluate(dir) | @expression2.evaluate(dir)
    end
end

class And < Expression
    def initialize(expression1, expression2)
        @expression1 = expression1
        @expression2 = expression2
    end

    def evaluate(dir)
        @expression1.evaluate(dir) & @expression2.evaluate(dir)
    end
end

puts FileName.new("*.rb").evaluate("../../../")
puts And.new(Not.new(BigFile.new(100)),FileName.new("*master")).evaluate("../../../")
