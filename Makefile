.PHONY: dev compose-up compose-down

dev:  ## Setup dev environment
	poetry install
	poetry run pre-commit install

format: dev  ## Scan and format all files with pre-commit
	poetry run pre-commit run --all-files

compose-up:
	docker-compose -f docker-compose-local.yaml up -d

compose-down:
	docker-compose -f docker-compose-local.yaml down -v
