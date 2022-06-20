#!/bin/sh
docker-compose up -d --build dagster_postgresql
docker-compose run --rm dagster_daemon dagster pulsar_dagit instance migrate
docker-compose run --rm dagster_daemon dagster schedule up
docker-compose run --rm dagster_daemon dagster schedule restart --restart-all-running
docker-compose up -d --build dagit
docker-compose up -d --build dagster_daemon 
docker-compose up -d --build dagster_pipelines
