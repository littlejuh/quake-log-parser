# frozen_string_literal: true

require 'spec_helper'

describe QuakeLogParser::Kill do
  let(:killer) { double(QuakeLogParser::Player) }
  let(:killed) { double(QuakeLogParser::Player) }
  let(:cause) { 'NATURAL_DEATH' }
  subject { described_class.new(killer: killer, killed: killed, cause: cause) }
  context '#initialize' do
    it { expect(subject.killer).to eql(killer) }
    it { expect(subject.killed).to eql(killed) }
    it { expect(subject.cause).to eql(cause) }
  end
end
