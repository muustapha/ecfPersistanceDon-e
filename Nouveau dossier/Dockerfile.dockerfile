# Dockerfile
FROM postgres:13.0-alpine
COPY init.sql.Docker.sql /docker-entrypoint-initdb.d/init.sql
