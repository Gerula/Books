module Subject
    def initialize
        @observers = []
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

