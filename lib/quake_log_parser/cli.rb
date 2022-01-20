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
      QuakeLogParser.new(log_path: log_path).execute
    end

    desc 'version', 'QuakeLogParser version'
    def version
      puts VERSION
    end
  end
end
