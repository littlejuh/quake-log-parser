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
      killer = create_killer(killer: LoglineUtil.killer(line: logline)) unless world
      killed = Player.new(name: LoglineUtil.killed(line: logline))

      add_players(players: [killer, killed])

      kill = Kill.new(killer: killer, killed: killed, cause: LoglineUtil.kill_cause(line: logline))

      @log.current_game.add_kill(kill: kill)
    end

    def create_killer(killer:)
      killer_player = @log.current_game.find_player(name: killer)
      return Player.new(name: killer) if killer_player.nil?

      killer_player
    end

    def add_players(players:)
      players.each do |player|
        @log.current_game.add_player(player: player) unless player.nil?
      end
    end
  end
end
