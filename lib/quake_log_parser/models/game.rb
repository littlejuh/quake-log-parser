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

    def find_player(name:)
      @players.find { |player| player.name.eql? name }
    end

    def add_kill(kill:)
      @kills.push(kill) unless @kills.include?(kill)
    end

    def total_kills
      @kills.size
    end

    def players_names
      @players.map(&:name)
    end

    def players_score
      players_score = {}
      @players.each do |player|
        players_score[player.name] = player.score
      end
      players_score
    end

    def kills_by_means
      kill_causes = {}

      @kills.each do |kill|
        kill_causes[kill.cause] = 0 unless kill_causes.key?(kill.cause)
        score = kill_causes[kill.cause]
        kill_causes[kill.cause] = score + 1
      end
      kill_causes
    end
  end
end
