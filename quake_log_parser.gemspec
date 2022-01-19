# frozen_string_literal: true

require File.expand_path('lib/quake_log_parser/version', __dir__)

Gem::Specification.new do |spec|
  # Metadata
  spec.required_ruby_version = '~> 3.0'
  spec.name = 'quakeLogParser'
  spec.version = QuakeLogParser::VERSION
  spec.authors = ['Juliana R Fernandes']
  spec.email = ['fernandes.juliana.dev@gmail.com']
  spec.summary = 'Quake Log Parser'
  spec.description = 'Project to parse the Quake log file.'

  # Manifest
  spec.files = `git ls-files`.split("\n")
  spec.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor', '~> 1.2.1'
end
