# frozen_string_literal: true

require 'thor'
require 'quake_log_parser_initializer'

trap('SIGINT') { exit! }

module QuakeLogParser
  class CLI < Thor
    include Thor::Actions
    LOG_FILE = './resources/qgames.log'

    map %w[-v --version] => :version

    desc 'main', 'QuakeLogParser Main'
    def main(log_path: LOG_FILE)
      logger = Logger.new
      logger.info(message: 'started execute parse')
      begin
        parser = QuakeLogParser.new(log_path: log_path).execute
        puts parser.render
      rescue StandardError => e
        logger.error(message: "an error has occurred. reason: #{e.message}")
        raise StandardError
      end
      logger.info(message: 'finished')
    end
    desc 'version', 'QuakeLogParser version'
    def version
      puts VERSION
    end
  end
end
