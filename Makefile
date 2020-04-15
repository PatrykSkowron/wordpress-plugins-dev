
PASSWORD ?= qwerty12345!

.PHONNY: run
run:
	docker-compose up -d

.PHONNY: stop
stop:
	docker-compose stop
