class Employee
    attr_reader :name, :title, :salary

    def initialize(name, title, salary, payroll)
        @name = name
        @title = title
        @salary = salary
        @payroll = payroll
    end

    def salary=(new_salary)
        @salary = new_salary
        @payroll.update(self)
    end
end

class Payroll
    def update(employee)
        puts "Send a check to #{employee.name}"
        puts "His salary is now #{employee.salary}"
    end
end

flintstone = Employee.new("Fred", "Dinosaur operator", 100000, Payroll.new)
puts flintstone.inspect
flintstone.salary += 10000
puts flintstone.inspect


