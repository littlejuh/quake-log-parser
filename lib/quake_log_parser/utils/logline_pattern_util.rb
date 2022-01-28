# frozen_string_literal: true

module QuakeLogParser
  class LoglineUtil
    PATTERNS = {
      game: /(?:^|\W)InitGame(?:$|\W)/,
      kill: /\sKill:[\s|\d]+:\s(?<killer_name>[\w+|\s]+)\skilled\s(?<killed_name>[\w+|\s]+)\sby\s(?<mod_weapon>\w+)/,
      kill_by_world: /\sKill:\s1022[\s\d+]+:\s<world>\skilled\s(?<killed_name>[\w+|\s]+)\sby\s(?<mod_weapon>\w+)/
    }.freeze

    def self.init_game?(line:)
      line.match?(PATTERNS[:game])
    end

    def self.kill?(line:)
      line.match?(PATTERNS[:kill])
    end

    def self.kill_by_world?(line:)
      line.match?(PATTERNS[:kill_by_world])
    end

    def self.killed(line:)
      line.split('killed')[1].split('by')[0].strip
    end

    def self.killer(line:)
      line.split(':')[3].split('killed')[0].strip
    end

    def self.kill_cause(line:)
      line.split('killed')[1].split('by')[1].strip
    end
  end
end
