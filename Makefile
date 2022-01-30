build:
	bundle install
run: 
	bundle exec bin/quake_log_parser main
test:
	bundle exec rspec
lint:
	bundle exec rubocop -A
cli-version:
	bundle exec bin/quake_log_parser version
docker-build:
	docker build . -t quake-log-parser:latest	
docker-run:
	docker run -it quake-log-parser:latest bundle exec bin/quake_log_parser main
docker-test:
	docker run -it quake-log-parser:latest bundle exec rspec
docker-lint:
	docker run -it quake-log-parser:latest bundle exec rubocop -A
docker-cli-version:
	docker run -it quake-log-parser:latest bundle exec bin/quake_log_parser version