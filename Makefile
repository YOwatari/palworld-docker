export USER_ID := $(shell id -u)
export GROUP_ID := $(shell id -g)

run:
	docker compose --compatibility up --build -d
	$(MAKE) logs

logs:
	docker compose logs -f

exec:
	docker compose exec palworld-dedicated bash

stop:
	docker compose down

clean:
	docker compose down --rmi all --volumes --remove-orphans

