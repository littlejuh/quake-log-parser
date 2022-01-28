# frozen_string_literal: true

require 'spec_helper'
require './lib/quake_log_parser/cli'
require './lib/quake_log_parser/quake_log_parser'

describe QuakeLogParser::CLI do
  subject { described_class.new }

  context 'when version command' do
    let(:expected_version) { '0.2.0' }
    before do
      stub_const('QuakeLogParser::VERSION', expected_version)
    end

    it 'show version' do
      expect { subject.version }.to output(match(expected_version)).to_stdout
    end
  end

  context 'when main command' do
    let(:json_output) { 'json output' }
    let(:parser) { double(QuakeLogParser::QuakeLogParser) }
    let(:log_response) { double(QuakeLogParser::LogResponse, render: json_output) }

    before do
      allow(QuakeLogParser::QuakeLogParser).to receive(:new).with(log_path: log_path).and_return(parser)
      allow(parser).to receive(:execute).and_return(log_response)
    end

    context 'with default file' do
      let(:log_path) { './resources/qgames.log' }

      it 'quake log parser should have been called' do
        expect(parser).to receive(:execute)
        expect(log_response).to receive(:render)
        expect { subject.main }.to output(match(json_output)).to_stdout
      end
    end

    context 'with file path param' do
      let(:log_path) { './resources/123abc.log' }

      it 'quake log parser should have been called' do
        expect(parser).to receive(:execute)
        expect(log_response).to receive(:render)
        expect { subject.main(log_path: log_path) }.to output(match(json_output)).to_stdout
      end
    end
  end
end
