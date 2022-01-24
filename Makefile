run: 
	bundle exec bin/quake_log_parser main
build:
	bundle install
unit:
	bundle exec rspec
lint:
	bundle exec rubocop -A