# frozen_string_literal: true

module QuakeLogParser
  class LogResponse
    attr_reader :response

    def initialize(games:)
      @response = build_response(games: games)
    end

    private

    def build_response(games:)
      response = {}
      games.map.with_index(1) do |game, count|
        response["game_#{count}"] = GameResponse.new(game: game).response
      end
      response
    end
  end
end
