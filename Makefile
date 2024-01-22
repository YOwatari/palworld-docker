run:
	docker compose --compatibility up --build -d
	$(MAKE) logs

logs:
	docker compose logs -f

build stop:
	docker compose $@

clean:
	docker compose rm -v -f

