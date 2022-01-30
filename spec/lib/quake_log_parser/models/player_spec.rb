# frozen_string_literal: true

require 'spec_helper'

describe QuakeLogParser::Player do
  subject { described_class.new(name: 'Juju') }
  context '#score' do
    let(:expected_score) { 3 }
    it 'score point and return expected score' do
      subject.score_point
      subject.score_point
      subject.score_point
      expect(subject.score).to eql(expected_score)
    end
  end

  context '#downscore' do
    let(:expected_score) { 2 }
    it 'remove score point and return new expected score' do
      subject.score_point
      subject.score_point
      subject.score_point
      subject.downscore
      expect(subject.score).to eql(expected_score)
    end

    it 'remove score point cant return negative score' do
      subject.score_point
      subject.downscore
      subject.downscore
      subject.downscore
      subject.downscore
      expect(subject.score).to eql(0)
    end
  end
end
