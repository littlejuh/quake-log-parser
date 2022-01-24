# frozen_string_literal: true

module QuakeLogParser
  class Kill
    attr_accessor :killer, :killed, :cause

    def initialize(killer:, killed:, cause:)
      @killer = killer
      @killed = killed
      @cause = cause
    end
  end
end
