# frozen_string_literal: true

require 'spec_helper'

describe QuakeLogParser::LoglineUtil do
  let(:line) { '--- randon line ----' }
  context '#init_game?' do
    subject { described_class.init_game?(line: line) }
    context 'when InitGame line' do
      let(:line) do
        '0:00 InitGame: \sv_floodProtect\1\sv_maxPing\0\sv_minPing\0\sv_maxRate\10000\sv_minRate\0\sv_hostname\Code
        Miner Server\g_gametype\0\sv_privateClients\2\sv_maxclients\16\sv_allowDownload\0\dmflags\0\fraglimit\20\time
        limit\15\g_maxGameClients\0\capturelimit\8\version\ioq3 1.36 linux-x86_64 Apr 12 2009\protocol\68\mapname\q3d
        m17\gamename\baseq3\g_needpass\0'
      end

      it { expect(subject).to be_truthy }
    end

    context 'when not InitGame line' do
      it { expect(subject).to be_falsey }
    end
  end

  context '#kill?' do
    subject { described_class.kill?(line: line) }
    context 'when kill line' do
      let(:line) do
        '1:08 Kill: 3 2 6: Isgalamido killed Mocinha by MOD_ROCKET'
      end

      it { expect(subject).to be_truthy }
    end

    context 'when not kill line' do
      it { expect(subject).to be_falsey }
    end
  end

  context '#kill_by_world?' do
    subject { described_class.kill_by_world?(line: line) }
    context 'when kill line' do
      let(:line) do
        '1:26 Kill: 1022 4 22: <world> killed Zeh by MOD_TRIGGER_HURT'
      end

      it { expect(subject).to be_truthy }
    end

    context 'when not kill by world line' do
      it { expect(subject).to be_falsey }
    end
  end

  context '#killed' do
    subject { described_class.killed(line: line) }
    let(:line) do
      '1:08 Kill: 3 2 6: Isgalamido killed Mocinha by MOD_ROCKET'
    end

    it { expect(subject).to eql('Mocinha') }
  end

  context '#killed' do
    subject { described_class.killer(line: line) }
    let(:line) do
      '1:08 Kill: 3 2 6: Isgalamido killed Mocinha by MOD_ROCKET'
    end

    it { expect(subject).to eql('Isgalamido') }
  end

  context '#kill_cause' do
    subject { described_class.kill_cause(line: line) }
    let(:line) do
      '1:08 Kill: 3 2 6: Isgalamido killed Mocinha by MOD_ROCKET'
    end

    it { expect(subject).to eql('MOD_ROCKET') }
  end
end
