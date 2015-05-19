module Subject
    def initialize
        @observers = []
    end

    def notify_observers
        @observers.each {|observer|
            observer.call(self)
        }
    end

    def add_observer(&observer)
        @observers << observer
    end

    def delete_observer(observer)
        @observers.delete(observer)
    end
end

