FROM docker/compose:1.24.0

COPY . /dagster
WORKDIR /dagster
ENTRYPOINT ["sh", "entrypoint.sh"]
