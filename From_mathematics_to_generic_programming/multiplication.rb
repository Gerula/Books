require 'test/unit'
extend Test::Unit::Assertions

class Fixnum
    def *(other)
        if other == 1
            return self
        else 
            return self + self * (other - 1)
        end
    end
end

assert_equal(12, 6 * 2)
assert_equal(12, 2 * 6)
assert_equal(18, 3 * 6)
assert_equal(80, 10 * 8)
assert_equal(81, 9 * 9)
