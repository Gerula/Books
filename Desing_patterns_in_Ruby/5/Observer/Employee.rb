class Employee
    attr_reader :name, :title, :salary

    def initialize(name, title, salary)
        @name = name
        @title = title
        @salary = salary
        @observers = []
    end

    def salary=(new_salary)
        @salary = new_salary
        notify_observers
    end

    def notify_observers
        @observers.each {|observer|
            observer.notify(self)
        }
    end

    def register_observer(observer)
        @observers << observer
    end

    def unregister_observer(observer)
        @observers.delete(observer)
    end
end

class Payroll
    def notify(employee)
        puts "Send a check to #{employee.name}"
        puts "His salary is now #{employee.salary}"
    end
end

class Irs
    def notify(employee)
        puts "Will need to collect some taxes from #{employee.name} for the sum of #{employee.salary}"
    end
end

flintstone = Employee.new("Fred", "Dinosaur operator", 100000)
puts flintstone.inspect
flintstone.salary += 10000
puts flintstone.inspect
payroll = Payroll.new
irs = Irs.new
flintstone.register_observer(irs)
flintstone.register_observer(payroll)
flintstone.salary -= 100
flintstone.unregister_observer(payroll)
flintstone.salary -= 100

