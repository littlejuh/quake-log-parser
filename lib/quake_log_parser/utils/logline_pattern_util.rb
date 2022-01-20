# frozen_string_literal: true

module QuakeLogParser
  class LoglineUtil
    PATTERNS = {
      game: /(?:^|\W)InitGame(?:$|\W)/
    }.freeze
  end
end
