# frozen_string_literal: true

module QuakeLogParser
  class Player
    attr_accessor :name, :score

    def initialize(name:)
      @name = name
      @score = 0
    end
  end
end
