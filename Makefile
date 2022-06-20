.PHONY: clean dev venv help
.DEFAULT_GOAL := help
-include .env

help:
	@awk -F ':.*?## ' '/^[a-zA-Z]/ && NF==2 {printf "\033[36m  %-25s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

dev:  ## Setup dev environment
	poetry install
	poetry run pre-commit install

format: dev  ## Scan and format all files with pre-commit
	poetry run pre-commit run --all-files

test:  ## Run all tests
	@if [ -d "airflow/venv" ]; then\
		airflow/venv/bin/pytest -v; else\
		poetry run pytest -v;\
	fi

airflow: dev  ## Scaffold an Airflow project
	mkdir airflow
	git clone --depth=1 git@github.com:thinkingmachines/dwt-airflow-template.git airflow
	rm -rf airflow/.git

dagster: dev  ## Scaffold a Dagster project
	poetry add dagster
	poetry run dagster new-project $(project)
