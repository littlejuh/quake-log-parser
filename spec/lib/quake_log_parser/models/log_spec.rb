# frozen_string_literal: true

require 'spec_helper'

describe QuakeLogParser::Log do
  subject { described_class.new }
  context '#initialize' do
    let(:games) { [] }
    it { expect(subject.games).to eql(games) }
  end

  context '#add_game' do
    let(:game) { double(QuakeLogParser::Game) }
    it do
      subject.add_game(game: game)
      expect(subject.games).to include(game)
    end
    it 'cant add the same game multiple times' do
      subject.add_game(game: game)
      subject.add_game(game: game)
      expect(subject.games.size).to eq 1
    end
  end
end
