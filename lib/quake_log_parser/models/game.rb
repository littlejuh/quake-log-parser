# frozen_string_literal: true

module QuakeLogParser
  class Game
    attr_accessor :players, :kills

    def initialize
      @players = []
      @kills = []
    end

    def add_player(player:)
      @players.push(player) if find_player(name: player.name).nil?
    end

    def add_kill(kill:)
      @kills.push(kill) unless @kills.include?(kill)
    end

    def total_kills
      @kills.size
    end

    def find_player(name:)
      @players.find { |player| player.name.eql? name }
    end
  end
end
