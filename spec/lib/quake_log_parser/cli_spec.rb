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
    let(:parser_double) { double(QuakeLogParser::QuakeLogParser) }
    before do
      allow(QuakeLogParser::QuakeLogParser).to receive(:new).with(log_path: log_path).and_return(parser_double)
    end

    context 'with default file' do
      let(:log_path) { './resources/qgames.log' }
      it 'quake log parser should have been called' do
        expect(parser_double).to receive(:main)
        subject.main
      end
    end

    context 'with file path param' do
      let(:log_path) { './resources/123abc.log' }

      it 'quake log parser should have been called' do
        expect(parser_double).to receive(:main)
        subject.main(log_path: log_path)
      end
    end
  end
end
