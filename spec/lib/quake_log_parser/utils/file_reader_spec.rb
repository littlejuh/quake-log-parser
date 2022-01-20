# frozen_string_literal: true

require 'spec_helper'

describe QuakeLogParser::FileReaderUtil do
  let(:file_path) { 'fakefile.log' }
  subject { described_class.read_file(filepath: file_path) }

  context 'when the file does not exists' do
    before { allow(File).to receive(:exist?).with(file_path).and_return(false) }
    it 'raise exception' do
      expect { subject }.to raise_error(ArgumentError)
    end
  end

  context 'when the file exists' do
    let(:stub_content) { "lorem\nipsum\ndollor\nsit\namet\n" }
    let(:stub_file) { StringIO.new(stub_content) }

    before do
      allow(File).to receive(:exist?).with(file_path).and_return(true)
      allow(File).to receive(:open).and_return(stub_file)
    end

    it 'should open' do
      expect(stub_file).to receive(:close)
      subject
    end

    it 'should return each line as array element' do
      expected_content = %w[lorem ipsum dollor sit amet]
      expect(subject).to match_array(expected_content)
    end
  end
end
