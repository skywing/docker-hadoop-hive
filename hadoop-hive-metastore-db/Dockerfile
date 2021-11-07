FROM centos/postgresql-12-centos7
# FROM postgres:13

LABEL platform="dev-hadooop-hive"

COPY ./hive-schema-2.3.0.postgres.sql /tmp/hive-schema-2.3.0.postgres.sql
COPY ./hive-txn-schema-2.3.0.postgres.sql /tmp/hive-txn-schema-2.3.0.postgres.sql
COPY ./init-hive-db.sh /usr/share/container-scripts/postgresql/start/z1-init-hive-db.sh

EXPOSE 5432
