# frozen_string_literal: true

module QuakeLogParser
  class Logger
    LOG_LEVEL = ENV['LOG_LEVEL'] || 'INFO'

    def initialize
      @logger = ::Logger.new($stdout)
      @logger.level = ::Logger.const_get LOG_LEVEL
      @logger.datetime_format = '%Y-%m-%d %H:%M:%S'
      original_formatter = ::Logger::Formatter.new
      @logger.formatter = proc do |severity, datetime, progname, msg|
        original_formatter.call(severity, datetime, progname, msg.dump)
      end
    end

    def info(message:)
      @logger.info(progname) { message }
    end

    def error(message:)
      @logger.error(progname) { message }
    end

    def debug(message:)
      @logger.debug(progname) { message }
    end

    private

    def progname
      self.class.to_s.split('::').first
    end
  end
end
