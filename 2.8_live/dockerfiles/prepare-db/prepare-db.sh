#!/bin/bash

if [ -f .bootstrap.lock ]; then
  echo 'Error: Installation already finished, dont start this container' >&2
  exit 1
fi

# Fix CRLF to LF to avoid empty .env variables in sh scripts
sed -i 's/^M$//' ".env"
sed -i $'s/\r$//' ".env"
source .env

echo "Using mysqladmin to ping..."

while ! mysqladmin ping --host 172.10.3.100 -u root -p"$MYSQL_ROOT_PASSWORD" --connect-timeout 3; do
  echo "Waiting for MySQL to start up..."
  sleep 3 # wait for mariadb to initialize itself
done

echo "Importing..."
mysql -h172.10.3.100 -u root -p"$MYSQL_ROOT_PASSWORD" < bootstrap.sql
mysql -h172.10.3.100 -u hk4e_work -pmiHoYo2012 < data.sql
mysql -h172.10.3.100 -u hk4e_work -pmiHoYo2012 < adjust.sql

echo "Database imported"