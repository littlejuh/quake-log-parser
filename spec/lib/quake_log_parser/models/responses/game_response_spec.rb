# frozen_string_literal: true

require 'spec_helper'

describe QuakeLogParser::GameResponse do
  describe '#initialize' do
    let(:game) { QuakeLogParser::Game.new }
    let(:name) { 'Fulaninho' }
    let(:name_two) { 'Ciclaninho' }
    let(:another_name) { 'Jujubinha' }
    let(:player_one) { QuakeLogParser::Player.new(name: name) }
    let(:player_two) { QuakeLogParser::Player.new(name: name_two) }
    let(:another_player) { QuakeLogParser::Player.new(name: another_name) }
    let(:kill_cause) { 'WORLD DEATH' }
    let(:second_kill_cause) { 'OVERDOSE DEATH' }

    let(:fake_kill) { double(QuakeLogParser::Kill, cause: kill_cause) }
    let(:another_fake_kill) { double(QuakeLogParser::Kill, cause: second_kill_cause) }
    let(:expected_response) do
      {
        'total_kills': 2,
        'players': [name, name_two, another_name],
        'kills': { name => 3, name_two => 2, another_name => 1 },
        'kills_by_means': { kill_cause => 1, second_kill_cause => 1 }

      }
    end
    before do
      player_one.score_point
      player_one.score_point
      player_one.score_point

      player_two.score_point
      player_two.score_point

      another_player.score_point

      game.add_player(player: player_one)
      game.add_player(player: player_two)
      game.add_player(player: another_player)

      game.add_kill(kill: fake_kill)
      game.add_kill(kill: another_fake_kill)
    end

    subject { described_class.new(game: game) }
    it { expect(subject.response).to eql(expected_response) }
  end
end
