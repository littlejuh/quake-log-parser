# frozen_string_literal: true

module QuakeLogParser
  class Game
    attr_accessor :players, :kills

    def initialize
      @players = []
      @kills = []
    end
  end
end
