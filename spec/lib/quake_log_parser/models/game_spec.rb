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

  context '#add_player' do
    let(:player_name) { 'Fulaninho' }
    let(:player) { QuakeLogParser::Player.new(name: player_name) }

    it do
      subject.add_player(player: player)
      expect(subject.players).to include(player)
      expect(subject.players.size).to eq(1)
    end
    context 'cant add the same player' do
      let(:player_two) { QuakeLogParser::Player.new(name: player_name) }
      let(:another_player) { QuakeLogParser::Player.new(name: 'Ciclaninho') }
      it do
        subject.add_player(player: player)
        subject.add_player(player: player_two)
        subject.add_player(player: another_player)
        expect(subject.players).to include(player)
        expect(subject.players).to_not include(player_two)
        expect(subject.players).to include(another_player)
        expect(subject.players.size).to eq(2)
      end
    end
  end

  context '#add_kill' do
    let(:kill) { double(QuakeLogParser::Kill) }

    it do
      subject.add_kill(kill: kill)
      expect(subject.kills).to include(kill)
    end

    it 'cant add the same kill multiple times' do
      subject.add_kill(kill: kill)
      subject.add_kill(kill: kill)
      expect(subject.kills.size).to eq 1
    end
  end
end
