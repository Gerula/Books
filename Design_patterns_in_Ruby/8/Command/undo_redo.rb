class Command
    attr_reader :description

    def initialize(description)
        @description = description
    end

    def execute
    end
end

class CreateFile < Command
    def initialize(path, contents)
        super("Create file #{path}")
        @path = path
        @contents = contents
    end

    def execute
        f = File.open(@path, "w")
        f.write(@contents)
        f.close
    end
end

class DeleteFile < Command
    def initialize(path)
        super("Delete file #{path}")
        @path = path
    end

    def execute
        File.delete(@path)
    end
end

class CopyFile < Command
    def initialize(source, destination)
        super("Copy file from #{source} to #{destination}")
        @source = source
        @destination = destination
    end

    def execute
        File.copy(@source, @destination)
    end
end

class CompositeCommand < Command
    def initialize
        @commands = []
    end

    def <<(command)
        @commands << command
    end

    def execute
        @commands.each{ |command| command.execute}
    end

    def description
        @commands.map{|x| x.description}.join("\n")
    end
end

commands = CompositeCommand.new
commands << CreateFile.new("NewFile", "Text")
commands << CopyFile.new("NewFile", "NewFile2")
commands << DeleteFile.new("NewFile")
commands << DeleteFile.new("NewFile2")

puts commands.description
