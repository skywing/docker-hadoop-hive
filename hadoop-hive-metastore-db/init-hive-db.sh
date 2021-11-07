!#!/bin/bash

db_exists=`echo "select count(*) from pg_database where datname = 'metastore';" | psql -qAt -d postgres`
if [ $db_exists -eq 0 ]
then
  echo "initializing Hive Metastore DB!"
  set -e
  psql -v ON_ERROR_STOP=1 --username "postgres" <<-EOSQL
    CREATE USER hive WITH PASSWORD 'hive';
    CREATE DATABASE metastore;
    GRANT ALL PRIVILEGES ON DATABASE metastore TO hive;
    \c metastore
    \i /tmp/hive-schema-2.3.0.postgres.sql
    \i /tmp/hive-txn-schema-2.3.0.postgres.sql
    \pset tuples_only
    \o /tmp/grant-privs
  SELECT 'GRANT SELECT,INSERT,UPDATE,DELETE ON "' || schemaname || '"."' || tablename || '" TO hive ;'
  FROM pg_tables
  WHERE tableowner = CURRENT_USER and schemaname = 'public';
    \o
    \i /tmp/grant-privs
EOSQL
  echo "initializing Metastore DB - COMPLETE!"
else
  echo "Metastore DB exists!!!!"
fi
