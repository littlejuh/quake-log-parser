# frozen_string_literal: true

module QuakeLogParser
  class QuakeLogParser
    def initialize(log_path:)
      @log_path = log_path
      @log = Log.new
    end

    def execute
      log_content = FileReaderUtil.read_file(filepath: @log_path)
      logline_service = LoglineService.new(log: @log)
      log_content.each do |log_line|
        @log = logline_service.execute(logline: log_line)
      end
      build_response
    end

    private

    def build_response
      LogResponse.new(log: @log)
    end
  end
end
