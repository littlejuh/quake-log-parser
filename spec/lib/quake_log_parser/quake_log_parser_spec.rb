# frozen_string_literal: true

require 'spec_helper'

describe QuakeLogParser::QuakeLogParser do
  subject { described_class.new(log_path: 'filepath') }

  context 'execute' do
    let(:log_content) do
      %w[
        InitGame
        Kill
      ]
    end
    let(:logline_service) { double(QuakeLogParser::LoglineService) }
    before do
      allow(QuakeLogParser::FileReaderUtil).to receive(:read_file).and_return(log_content)
      allow(QuakeLogParser::LoglineService).to receive(:new).and_return(logline_service)
      allow(logline_service).to receive(:execute)
    end

    it 'should parse log content' do
      expect(logline_service).to receive(:execute).exactly(log_content.size).times
      subject.execute
    end
  end
end
