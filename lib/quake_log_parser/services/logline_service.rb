# frozen_string_literal: true

module QuakeLogParser
  class LoglineService
    def initialize(log:)
      @log = log
    end

    def execute(logline:)
      if logline.match?(LoglineUtil::PATTERNS[:game])
        @log.add_game(game: Game.new)
        return true
      end

      false
    end
  end
end
