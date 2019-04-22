#!/bin/bash
# Docker entrypoint script.

service ssh start

# Wait until Postgres is ready
while ! pg_isready -q -h db -p 5432 -U postgres
do
  sleep 2
done

# Create, migrate, and seed database if it doesn't exist.
if [[ -z `psql -Atqc "\\list bankchallenge"` ]]; then
  mix ecto.create
  mix ecto.migrate
  mix run priv/repo/seeds.exs
  mix event_store.create
  mix event_store.init
fi

mix ecto.migrate
mix phx.server