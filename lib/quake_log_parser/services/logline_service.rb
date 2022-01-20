# frozen_string_literal: true

module QuakeLogParser
  class LoglineService
    def initialize(log:)
      @log = log
    end

    def execute(logline:)
      return true if logline.match?(LoglineUtil::PATTERNS[:game])

      false
    end
  end
end
