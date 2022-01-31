# frozen_string_literal: true

module QuakeLogParser
  class LoglineService
    def initialize(log:)
      @log = log
    end

    def execute(logline:)
      @log.add_game(game: Game.new) if LoglineUtil.init_game?(line: logline)
      execute_kill(logline: logline) if LoglineUtil.kill?(line: logline)
      execute_kill(logline: logline, world: true) if LoglineUtil.kill_by_world?(line: logline)
      @log
    end

    private

    def execute_kill(logline:, world: false)
      CurrentGameService.new.execute_kill(log: @log, logline: logline, world: world)
    end
  end
end
