require "observer"

class Employee
    include Observable

    attr_reader :name, :title, :salary

    def initialize(name, title, salary)
        super()
        @name = name
        @title = title
        @salary = salary
    end

    def salary=(new_salary)
        @salary = new_salary
        changed
        notify_observers(self)
    end
end

class Payroll
    def update(employee)
        puts "Send a check to #{employee.name}"
        puts "His salary is now #{employee.salary}"
    end
end

class Irs
    def update(employee)
        puts "Will need to collect some taxes from #{employee.name} for the sum of #{employee.salary}"
    end
end

flintstone = Employee.new("Fred", "Dinosaur operator", 100000)
puts flintstone.inspect
flintstone.salary += 10000
puts flintstone.inspect
payroll = Payroll.new
irs = Irs.new
flintstone.add_observer(irs)
flintstone.add_observer(payroll)
flintstone.salary -= 100
flintstone.delete_observer(payroll)
flintstone.salary -= 100

