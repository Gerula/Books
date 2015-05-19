require 'etc'

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
    def initialize(real_bank_account, owner)
        @real_bank_account = real_bank_account
        @owner = owner
    end

    def balance
        check_login
        @real_bank_account.balance
    end

    def deposit(money)
        check_login
        @real_bank_account.deposit(money)
    end

    def withdraw(money)
        check_login
        @real_bank_account.withdraw(money)
    end

    def check_login
        if Etc.getlogin != @owner
            raise "Not authorized:"
        end
    end
end  

ba = BankAccount.new(100)
ba.deposit(10)
ba.withdraw(50)
puts ba.inspect
bap = BankAccountProxy.new(ba, "Gerula")
bap.deposit(10)
bap.withdraw(50)
puts bap.inspect
