run:
	docker compose --compatibility up --build

build stop:
	docker compose $@

clean:
	docker compose rm -v -f

