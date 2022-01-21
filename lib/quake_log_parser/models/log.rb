# frozen_string_literal: true

module QuakeLogParser
  class Log
    attr_accessor :games

    def initialize
      @games = []
    end

    def add_game(game:)
      @games.push(game) unless @games.include?(game)
    end
  end
end
