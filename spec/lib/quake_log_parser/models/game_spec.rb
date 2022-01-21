# frozen_string_literal: true

require 'spec_helper'

describe QuakeLogParser::Game do
  subject { described_class.new }
  context '#initialize' do
    let(:players) { [] }
    let(:kills) { [] }
    it { expect(subject.players).to eql(players) }
    it { expect(subject.kills).to eql(kills) }
  end
end
