# frozen_string_literal: true

require 'spec_helper'

describe QuakeLogParser::LogResponse do
  describe '#initialize' do
    let(:first_game) { QuakeLogParser::Game.new }
    let(:second_game) { QuakeLogParser::Game.new }
    let(:games) { [first_game, second_game] }
    let(:expected_response) { { 'game_1' => { total_kills: 0 }, 'game_2' => { total_kills: 0 } } }

    subject { described_class.new(games: games) }
    it { expect(subject.response).to eql(expected_response) }
  end
end
