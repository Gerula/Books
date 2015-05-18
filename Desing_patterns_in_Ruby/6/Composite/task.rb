# Composite pattern - the sum acts like one of the parts

class Task
    attr_reader :name

    def initialize(name)
        @name = name
    end

    def get_time_required
        0.0
    end
end

class AddDryIngredientsTask < Task
    def initialize
        super("Add dry ingredients")
    end

    def get_time_required
        1.0
    end
end

class MixIngredientsTask < Task
    def initialize
        super("Mix ingredients")
    end

    def get_time_required
        3.0
    end
end

class CompositeTask < Task
    def initialize(name)
        super(name)
        @sub_tasks = []
    end

    def add_sub_task(task)
        @sub_tasks << task
    end

    def remove_sub_task(task)
        @sub_tasks.delete(task)
    end

    def get_time_required
        @sub_tasks.map(&:get_time_required).reduce(:+)
    end
end

class MakeBatterTask < CompositeTask
    def initialize
        super("Make batter")
        add_sub_task(AddDryIngredientsTask.new)
        add_sub_task(MixIngredientsTask.new)
    end
end

puts MakeBatterTask.new.get_time_required
