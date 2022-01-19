# frozen_string_literal: true

require 'thor'
require 'quake_log_parser_initializer'

trap('SIGINT') { exit! }

module QuakeLogParser
  class CLI < Thor
    include Thor::Actions

    map %w[-v --version] => :version

    desc 'version', 'QuakeLogParser version'
    def version
      puts VERSION
    end
  end
end
