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

    def pleb(other)
        small = [self, other].min
        large = [self, other].max
        result = 0
        while small != 0
            small, remainder = small.divmod(2)
            result += remainder == 0 ? 0 : large
            large *= 2
        end

        return result
    end
end

assert_equal(12, 6 * 2)
assert_equal(12, 2 * 6)
assert_equal(18, 3 * 6)
assert_equal(80, 10 * 8)
assert_equal(81, 9 * 9)
assert_equal(12, 6.pleb(2))
assert_equal(12, 2.pleb(6))
assert_equal(18, 3.pleb(6))
assert_equal(80, 10.pleb(8))
assert_equal(81, 9.pleb(9))
