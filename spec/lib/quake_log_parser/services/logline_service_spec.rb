# frozen_string_literal: true

require 'spec_helper'

describe QuakeLogParser::LoglineService do
  let(:log) { double(QuakeLogParser::Log) }
  subject { described_class.new(log: log) }

  context '#execute InitGame line' do
    let(:init_game_line) do
      '0:00 InitGame:
      \sv_floodProtect\1\sv_maxPing\0\sv_minPing\0\sv_maxRate\10000\sv_minRate\0\sv_hostname\
      Code Miner Server\g_gametype\0\sv_privateClients\2\sv_maxclients\16\sv_allowDownload\0\
      dmflags\0\fraglimit\20\timelimit\15\g_maxGameClients\0\capturelimit\8\version\ioq3
       1.36 linux-x86_64 Apr 12 2009\protocol\68\mapname\q3dm17\gamename\baseq3\g_needpass\0'
    end

    it 'should add game' do
      expect(log).to receive(:add_game)
      subject.execute(logline: init_game_line)
    end
  end

  context '#execute kill line' do
    let(:current_game_service) { QuakeLogParser::CurrentGameService.new }
    let(:kill_line) do
      '22:06 Kill: 2 3 7: Isgalamido killed Mocinha by MOD_ROCKET_SPLASH'
    end

    before do
      allow(QuakeLogParser::CurrentGameService).to receive(:new).and_return(current_game_service)
    end

    it 'should add kill in current game' do
      expect(current_game_service).to receive(:execute_kill).with(log: log, logline: kill_line, world: false)
      expect(subject.execute(logline: kill_line)).to eql(log)
    end
  end

  context '#execute kill by world line' do
    let(:current_game_service) { QuakeLogParser::CurrentGameService.new }
    let(:kill_line) do
      '20:54 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT'
    end

    before do
      allow(QuakeLogParser::CurrentGameService).to receive(:new).and_return(current_game_service)
    end

    it 'should add kill in current game' do
      expect(current_game_service).to receive(:execute_kill).with(log: log, logline: kill_line, world: true)
      expect(subject.execute(logline: kill_line)).to eql(log)
    end
  end

  context 'execute other lines' do
    let(:line) { 'abcd' }

    it 'should return empty log' do
      expect(log).not_to receive(:current_game)
      expect(subject.execute(logline: line)).to eql(log)
    end
  end
end
