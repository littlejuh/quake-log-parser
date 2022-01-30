# frozen_string_literal: true

module QuakeLogParser
  class GameResponse
    attr_reader :response

    def initialize(game:)
      @response =
        {
          'total_kills': game.total_kills,
          'players': game.players_names,
          'kills': game.players_score,
          'kills_by_means': game.kills_by_means
        }
    end
  end
end
