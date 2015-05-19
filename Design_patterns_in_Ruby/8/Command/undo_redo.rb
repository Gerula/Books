require 'fileutils'

class Command
    attr_reader :description

    def initialize(description)
        @description = description
    end

    def execute
    end

    def unexecute
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

    def unexecute
        File.delete(@path)
    end
end

class DeleteFile < Command
    def initialize(path)
        super("Delete file #{path}")
        @path = path
        @contents = File.read(@path) if File.exists?(@path)
    end

    def execute
        File.delete(@path)
    end

    def unexecute
        File.open(@path, "w").write(@contents)
    end
end

class CopyFile < Command
    def initialize(source, destination)
        super("Copy file from #{source} to #{destination}")
        @source = source
        @destination = destination
    end

    def execute
        FileUtils.copy(@source, @destination)
    end

    def unexecute
        File.delete(@destination)
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

    def unexecute
        @commands.reverse_each{|command| command.unexecute}
    end
end

commands = CompositeCommand.new
commands << CreateFile.new("NewFile", "Text")
commands << CopyFile.new("NewFile", "NewFile2")
commands << DeleteFile.new("NewFile")
commands << DeleteFile.new("NewFile2")

puts commands.description

commands.execute
commands.unexecute
