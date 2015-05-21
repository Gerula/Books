class Logger
    attr_accessor :level

    ERROR = 1
    WARNING = 2
    INFO = 3

    def initialize
        @log = File.open("log.log", "w")
        @level = WARNING
    end

    def error(msg)
        @log.puts(msg)
        @log.flush
    end

    def warning(msg)
        @log.puts(msg) if @level >= WARNING
        @log.flush
    end

    def info(msg)
        @log.puts(msg) if @level >= INFO
        @log.flush
    end

    @@instance = Logger.new

    def self.instance
        @@instance
    end

    private_class_method :new
end

Logger.instance.warning("third line")
