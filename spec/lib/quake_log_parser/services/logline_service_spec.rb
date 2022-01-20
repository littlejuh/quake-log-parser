# frozen_string_literal: true

require 'spec_helper'

describe QuakeLogParser::LoglineService do
  let(:log) { QuakeLogParser::Log.new }
  subject { described_class.new(log: log) }

  context 'execute when InitLine' do
    let(:init_game_line) do
      '0:00 InitGame:
      \sv_floodProtect\1\sv_maxPing\0\sv_minPing\0\sv_maxRate\10000\sv_minRate\0\sv_hostname\
      Code Miner Server\g_gametype\0\sv_privateClients\2\sv_maxclients\16\sv_allowDownload\0\
      dmflags\0\fraglimit\20\timelimit\15\g_maxGameClients\0\capturelimit\8\version\ioq3
       1.36 linux-x86_64 Apr 12 2009\protocol\68\mapname\q3dm17\gamename\baseq3\g_needpass\0'
    end

    it 'should be true' do
      expect(subject.execute(logline: init_game_line)).to be_truthy
    end
  end

  context 'execute when other lines' do
    let(:line) { 'abcd' }

    it 'should be false' do
      expect(subject.execute(logline: line)).not_to be_truthy
    end
  end
end
