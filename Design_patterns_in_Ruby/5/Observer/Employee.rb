require_relative "Subject"

class Employee
    include Subject

    attr_reader :name, :title, :salary

    def initialize(name, title, salary)
        super()
        @name = name
        @title = title
        @salary = salary
    end

    def salary=(new_salary)
        unless new_salary == @salary
            @salary = new_salary
            notify_observers
        end
    end

    def title=(new_title)
        unless new_title == @title
            @title = new_title
            notify_observers
        end
    end
end

puts flintstone.inspect
flintstone.salary += 10000
puts flintstone.inspect

payroll = lambda do |subject|
    puts "Send a check to #{subject.name}"
    puts "His salary is now #{subject.salary}"
end

irs = lambda do |subject|
    puts "Will need to collect some taxes from #{subject.name} for the sum of #{subject.salary}"
end

flintstone.add_observer(&irs)
flintstone.add_observer(&payroll)
flintstone.salary -= 100
flintstone.delete_observer(payroll)
flintstone.salary -= 100

