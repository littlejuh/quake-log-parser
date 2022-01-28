# frozen_string_literal: true

require 'spec_helper'

describe QuakeLogParser::QuakeLogParser do
  subject { described_class.new(log_path: 'filepath') }

  context '#execute' do
    let(:log_content) do
      %w[
        InitGame
        Kill
        Randon Line
      ]
    end
    let(:logline_service) { double(QuakeLogParser::LoglineService) }
    let(:log) { double(QuakeLogParser::Log) }
    let(:games) { [double(QuakeLogParser::Game), double(QuakeLogParser::Game)] }
    let(:log_response) { double(QuakeLogParser::LogResponse) }

    before do
      allow(QuakeLogParser::FileReaderUtil).to receive(:read_file).and_return(log_content)
      allow(QuakeLogParser::LoglineService).to receive(:new).and_return(logline_service)
      allow(logline_service).to receive(:execute).and_return(log)
      allow(log).to receive(:games).and_return(games)
      allow(QuakeLogParser::LogResponse).to receive(:new).with(log: log).and_return(log_response)
    end

    it 'should get log response' do
      expect(logline_service).to receive(:execute).exactly(log_content.size).times
      expect(subject.execute).to eql(log_response)
    end
  end
end
