# frozen_string_literal: true

module QuakeLogParser
  class Player
    attr_accessor :name, :score

    def initialize(name:)
      @name = name
      @score = 0
    end

    def score_point
      @score += 1
      @score
    end
  end
end
