# frozen_string_literal: true

module QuakeLogParser
  class Log
    attr_accessor :games

    def initialize
      @games = []
    end
  end
end
