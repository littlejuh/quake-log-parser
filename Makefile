build:
	bundle install
unit:
	bundle exec rspec
lint:
	bundle exec rubocop -A