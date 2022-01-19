# frozen_string_literal: true

module FileReader
  def self.read_file(filepath:)
    raise ArgumentError, 'The file does not exists' unless File.exist?(filepath)

    file = File.open(filepath)
    file_content = file.readlines.map(&:chomp)
    file.close
    file_content
  end
end
