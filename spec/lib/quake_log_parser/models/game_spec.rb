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

  context '#players_name' do
    let(:name) { 'Fulaninho' }
    let(:name_two) { 'Ciclaninho' }
    let(:another_name) { 'Jujubinha' }
    let(:player_one) { QuakeLogParser::Player.new(name: name) }
    let(:player_two) { QuakeLogParser::Player.new(name: name_two) }
    let(:another_player) { QuakeLogParser::Player.new(name: another_name) }
    let(:expected_names) { [name, name_two, another_name] }

    before do
      subject.add_player(player: player_one)
      subject.add_player(player: player_two)
      subject.add_player(player: another_player)
    end

    it { expect(subject.players_names).to eq(expected_names) }
  end

  context '#players_score' do
    let(:name) { 'Fulaninho' }
    let(:name_two) { 'Ciclaninho' }
    let(:player_score) { 3 }
    let(:second_player_score) { 10 }
    let(:player_one) { double(QuakeLogParser::Player.new(name: name)) }
    let(:player_two) { double(QuakeLogParser::Player.new(name: name_two)) }

    let(:expected) { { name => player_score, name_two => second_player_score } }

    before do
      allow(player_one).to receive(:name).and_return(name)
      allow(player_two).to receive(:name).and_return(name_two)

      subject.add_player(player: player_one)
      subject.add_player(player: player_two)

      allow(player_one).to receive(:score).and_return(player_score)
      allow(player_two).to receive(:score).and_return(second_player_score)
    end

    it { expect(subject.players_score).to eq(expected) }
  end

  context '#kills_by_means' do
    let(:kill) { double(QuakeLogParser::Kill) }
    let(:second_kill) { double(QuakeLogParser::Kill) }
    let(:another_kill) { double(QuakeLogParser::Kill) }

    let(:expected) { { 'MOD_SHOTGUN' => 1, 'MOD_PLASMA' => 2 } }

    before do
      allow(kill).to receive(:cause).and_return('MOD_PLASMA')
      allow(second_kill).to receive(:cause).and_return('MOD_PLASMA')
      allow(another_kill).to receive(:cause).and_return('MOD_SHOTGUN')
      subject.add_kill(kill: kill)
      subject.add_kill(kill: second_kill)
      subject.add_kill(kill: another_kill)
    end

    it { expect(subject.kills_by_means).to eq(expected) }
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
