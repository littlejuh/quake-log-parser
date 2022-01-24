# frozen_string_literal: true

module QuakeLogParser
  class GameResponse
    attr_reader :response

    def initialize(game:)
      @response =
        {
          'total_kills': game.total_kills
        }
    end
  end
end
