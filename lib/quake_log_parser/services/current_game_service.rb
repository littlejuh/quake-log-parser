# frozen_string_literal: true

module QuakeLogParser
  class CurrentGameService
    def execute_kill(log:, logline:, world: false)
      killer = create_killer(log: log, killer: LoglineUtil.killer(line: logline)) unless world
      killed = Player.new(name: LoglineUtil.killed(line: logline))

      add_players(log: log, players: [killer, killed])

      killer&.score_point
      killed.downscore
      kill = Kill.new(killer: killer, killed: killed, cause: LoglineUtil.kill_cause(line: logline))
      log.current_game.add_kill(kill: kill)
      log
    end

    private

    def create_killer(log:, killer:)
      killer_player = log.current_game.find_player(name: killer)
      return Player.new(name: killer) if killer_player.nil?

      killer_player
    end

    def add_players(log:, players:)
      players.each do |player|
        log.current_game.add_player(player: player) unless player.nil?
      end
    end
  end
end
