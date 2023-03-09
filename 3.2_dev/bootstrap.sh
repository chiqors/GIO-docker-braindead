#!/bin/bash

if ! [ -x "$(command -v docker)" ]; then
  echo 'E: Please install Docker and Compose plugin' >&2
  exit 1
fi

if ! id -Gn | grep -qw 'docker'; then
  echo 'E: Current user does not belong to "docker" group' >&2
  exit
fi

if ! [ -x "$(command -v mysql)" ]; then
  echo 'E: Please install MySQL/MariaDB _client_' >&2
  exit 1
fi

# ---

if [ -f .bootstrap.lock ]; then
  echo 'E: Installation already finished; please delete ".bootstrap.lock" file if you wish to re-run it; note that it will _destroy_ current data in database!' >&2
  exit 1
fi

# ---

read -p 'Outer IP: ' OUTER_IP
MYSQL_ROOT_PASSWORD=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c16)
FLASK_SECRET_KEY=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c16)

# ---

sed "s/%MYSQL_ROOT_PASSWORD%/$MYSQL_ROOT_PASSWORD/g" docker-compose.yml.tmpl > docker-compose.yml
sed "s/%FLASK_SECRET_KEY%/$FLASK_SECRET_KEY/g" sdk/data/config.json.tmpl > sdk/data/config.json

sed "s/%OUTER_IP%/$OUTER_IP/g" server/dbgate/conf/dbgate.xml.tmpl > server/dbgate/conf/dbgate.xml
sed "s/%OUTER_IP%/$OUTER_IP/g" server/dispatch/conf/dispatch.xml.tmpl > server/dispatch/conf/dispatch.xml
sed "s/%OUTER_IP%/$OUTER_IP/g" server/gameserver/conf/gameserver.xml.tmpl > server/gameserver/conf/gameserver.xml
sed "s/%OUTER_IP%/$OUTER_IP/g" server/gateserver/conf/gateserver.xml.tmpl > server/gateserver/conf/gateserver.xml
sed "s/%OUTER_IP%/$OUTER_IP/g" server/muipserver/conf/muipserver.xml.tmpl > server/muipserver/conf/muipserver.xml
sed "s/%OUTER_IP%/$OUTER_IP/g" server/multiserver/conf/multiserver.xml.tmpl > server/multiserver/conf/multiserver.xml
sed "s/%OUTER_IP%/$OUTER_IP/g" server/nodeserver/conf/nodeserver.xml.tmpl > server/nodeserver/conf/nodeserver.xml
sed "s/%OUTER_IP%/$OUTER_IP/g" server/oaserver/conf/oaserver.xml.tmpl > server/oaserver/conf/oaserver.xml
sed "s/%OUTER_IP%/$OUTER_IP/g" server/pathfindingserver/conf/pathfindingserver.xml.tmpl > server/pathfindingserver/conf/pathfindingserver.xml
sed "s/%OUTER_IP%/$OUTER_IP/g" server/tothemoonserver/conf/tothemoonserver.xml.tmpl > server/tothemoonserver/conf/tothemoonserver.xml


sed "s/%OUTER_IP%/$OUTER_IP/g" data.sql.tmpl > data.sql

# ---

docker compose up -d mysql redis

while ! mysqladmin ping -h172.10.3.100 > /dev/null 2>&1; do
  echo 'Waiting for MySQL to start up...'
  sleep 3 # wait for mariadb to initialize itself
done

mysql -h172.10.3.100 -uroot -p$MYSQL_ROOT_PASSWORD < bootstrap.sql
mysql -h172.10.3.100 -uhk4e_work -pmiHoYo2012 < data.sql
mysql -h172.10.3.100 -uhk4e_work -pmiHoYo2012 < adjust.sql

# ---

touch .bootstrap.lock
docker compose down

echo 'Installation done. Execute "docker compose up -d" to begin; have fun!'