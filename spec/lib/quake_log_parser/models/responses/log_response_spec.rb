# frozen_string_literal: true

require 'spec_helper'

describe QuakeLogParser::LogResponse do
  describe '#initialize' do
    let(:first_game) { QuakeLogParser::Game.new }
    let(:second_game) { QuakeLogParser::Game.new }
    let(:games) { [first_game, second_game] }
    let(:log) { double(QuakeLogParser::Log, games: games) }
    let(:expected_response) do
      { 'game_1' => { players: [], total_kills: 0 }, 'game_2' => { players: [], total_kills: 0 } }
    end

    subject { described_class.new(log: log) }
    it { expect(subject.response).to eql(expected_response) }
  end
end
