# Docker Hadoop - Hive metastore database

`Dockerfile` responsible for launching hive metastore postgresql database. Postgres database is used to store hive metadata.

## Hive Database Schema Scripts
The following scripts are used by the `init-hive-db.sh` to create the hive meta database.
- hive-schema-2.3.0.postgres.sql
- hive-txn-schema-2.3.0.postgres.sql

## Building the Image
```bash
docker build --no-cache -t hadoop-hive-metastore-db:latest .
```

## Running the Image
This should be run as part of the `docker-compose.yml`

