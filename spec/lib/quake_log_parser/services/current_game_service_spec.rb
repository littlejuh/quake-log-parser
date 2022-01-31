# frozen_string_literal: true

require 'spec_helper'

describe QuakeLogParser::CurrentGameService do
  let(:log) { double(QuakeLogParser::Log) }
  subject { described_class.new }
  context '#execute kill' do
    let(:kill_line) do
      '22:06 Kill: 2 3 7: Isgalamido killed Mocinha by MOD_ROCKET_SPLASH'
    end
    let(:game) { double(QuakeLogParser::Game) }
    let(:killer_name) { 'Isgalamido' }
    let(:killer_player) { double(QuakeLogParser::Player) }
    let(:killed_player) { double(QuakeLogParser::Player) }
    let(:kill) { double(QuakeLogParser::Kill) }

    before do
      allow(log).to receive(:current_game).and_return(game)
      allow(game).to receive(:find_player).with(name: killer_name).and_return(killer_player)
      allow(QuakeLogParser::Player).to receive(:new).with(name: killer_name).and_return(killer_player)
      allow(QuakeLogParser::Player).to receive(:new).with(name: 'Mocinha').and_return(killed_player)
      allow(QuakeLogParser::Kill).to receive(:new).with(killer: killer_player, killed: killed_player,
                                                        cause: 'MOD_ROCKET_SPLASH').and_return(kill)
    end

    it 'should add kill in current game' do
      expect(game).to receive(:add_player).with(player: killer_player)
      expect(game).to receive(:add_player).with(player: killed_player)
      expect(game).to receive(:add_kill).with(kill: kill)
      expect(killer_player).to receive(:score_point)
      expect(killed_player).to receive(:downscore)
      expect(subject.execute_kill(log: log, logline: kill_line)).to eql(log)
    end
  end

  context '#execute kill by world' do
    let(:kill_line) do
      '20:54 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT'
    end
    let(:game) { double(QuakeLogParser::Game) }
    let(:killed_player) { double(QuakeLogParser::Player) }
    let(:kill) { double(QuakeLogParser::Kill) }

    before do
      allow(log).to receive(:current_game).and_return(game)
      allow(QuakeLogParser::Player).to receive(:new).with(name: 'Isgalamido').and_return(killed_player)
      allow(QuakeLogParser::Kill).to receive(:new).with(killer: nil, killed: killed_player,
                                                        cause: 'MOD_TRIGGER_HURT').and_return(kill)
    end

    it 'should add kill in current game' do
      expect(game).to receive(:add_player).with(player: killed_player)
      expect(game).to receive(:add_kill).with(kill: kill)
      expect(killed_player).to receive(:downscore)
      expect(subject.execute_kill(log: log, logline: kill_line, world: true)).to eql(log)
    end
  end
end
