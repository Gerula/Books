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

    def method_missing(name, *args)
        @real_bank_account.send(name, *args)
    end
end  

class VirtualProxy
    def initialize(&creator)
        @creator = creator
    end

    def balance
        s = subject
        s.balance
    end

    def deposit(money)
        s = subject
        s.deposit(money)
    end

    def withdraw(money)
        s = subject
        s.withdraw(money)
    end

    def subject
        @subject ||  (@subject = @creator.call)
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

vap = VirtualProxy.new{BankAccount.new(100)}
vap.deposit(10)
vap.withdraw(50)
puts vap.inspect

