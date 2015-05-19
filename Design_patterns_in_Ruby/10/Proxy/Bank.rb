class BankAccount
    attr_reader :balance

    def initialize(starting_balance = 0)
        @balance = starting_balance
    end

    def deposit(money)
        @balance += money if money > 0
    end

    def withdraw(money)
        @balance -= money if money > 0
    end
end

class BankAccountProxy
    def initialize(real_bank_account)
        @real_bank_account = real_bank_account
    end

    def balance
        @real_bank_account.balance
    end

    def deposit(money)
        @real_bank_account.deposit(money)
    end

    def withdraw(money)
        @real_bank_account.withdraw(money)
    end
end  

ba = BankAccount.new(100)
ba.deposit(10)
ba.withdraw(50)
puts ba.inspect
bap = BankAccountProxy.new(ba)
bap.deposit(10)
bap.withdraw(50)
puts bap.inspect
