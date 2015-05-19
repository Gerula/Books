class Account
    attr_accessor :name, :balance

    def initialize(name, balance)
        @name = name
        @balance = balance
    end

    def <=>(other)
        self.balance <=> other.balance
    end
end

class Portfolio
    include Enumerable

    def initialize
        @accounts = []
    end

    def <<(account)
        @accounts << account
    end

    def each(&block)
        @accounts.each(&block)
    end
end

portfolio = Portfolio.new
portfolio << Account.new("x", 100)
portfolio << Account.new("z", 200)
portfolio << Account.new("y", 300)
portfolio << Account.new("p", 400)

puts portfolio.any? {|account| account.balance > 100}
