# frozen_string_literal: true

require 'spec_helper'
require './lib/quake_log_parser/utils/file_reader'

describe FileReader do
  subject { described_class.read_file(filepath: './resources/qgames.log') }

  context 'when the file does not exists' do
    before { allow(File).to receive(:exist?).and_return(false) }
    it 'raise exception' do
      expect { subject }.to raise_error(ArgumentError)
    end
  end

  context 'when the file exists' do
    it 'should open' do
      expect(File).to receive(:open)
      subject
    end
    it 'cant raise exception' do
      expect { subject }.not_to raise_error(ArgumentError)
    end
  end
end
