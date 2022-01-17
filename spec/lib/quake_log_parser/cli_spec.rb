require 'spec_helper'
require './lib/quake_log_parser/cli'

describe QuakeLogParser::CLI do
  subject { described_class.new }
 
  it "show version" do
    expected_version = '0.2.0'
    stub_const("QuakeLogParser::VERSION", expected_version)

    expect { subject.version }.to output(match(expected_version)).to_stdout
  end
end