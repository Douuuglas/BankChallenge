#!/bin/bash
# Docker entrypoint script.

# Wait until Postgres is ready
while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
do
  sleep 2
done

# Create, migrate, and seed database if it doesn't exist.
if [[ -z `psql -Atqc "\\list $PGDATABASE"` ]]; then
  mix ecto.create
  mix ecto.migrate
  mix run priv/repo/seeds.exs
  mix event_store.create
  mix event_store.init
fi

mix ecto.migrate
mix phx.server