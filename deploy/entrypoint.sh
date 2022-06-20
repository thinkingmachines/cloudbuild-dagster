#!/bin/sh
docker-compose up -d --build dagster_postgresql
docker-compose run --rm --entrypoint dagster dagster_daemon instance migrate
docker-compose run --rm --entrypoint dagster dagster_daemon schedule up
docker-compose run --rm --entrypoint dagster dagster_daemon schedule restart --restart-all-running
docker-compose up -d --build dagit
docker-compose up -d --build dagster_daemon 
docker-compose up -d --build dagster_pipelines
