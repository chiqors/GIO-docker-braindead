#!/bin/bash

if [ -f .bootstrap.lock ]; then
  echo 'Error: Installation already finished, dont start this container' >&2
  exit 1
fi

# Fix CRLF to LF to avoid empty .env variables in sh scripts
sed -i 's/^M$//' ".env"
sed -i $'s/\r$//' ".env"
source .env

sed "s/%MYSQL_ROOT_PASSWORD%/$MYSQL_ROOT_PASSWORD/g" docker-compose.yml.tmpl > docker-compose.yml
sed -i "s/%CPU_USAGE_LIMIT%/$CPU_USAGE_LIMIT/g" docker-compose.yml
sed -i "s/%OUTER_IP%/$OUTER_IP/g" docker-compose.yml

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

sed -i "s/%RELOAD_CONFIG_INTERVAL%/$RELOAD_CONFIG_INTERVAL/g" server/dbgate/conf/dbgate.xml
sed -i "s/%RELOAD_CONFIG_INTERVAL%/$RELOAD_CONFIG_INTERVAL/g" server/dispatch/conf/dispatch.xml
sed -i "s/%RELOAD_CONFIG_INTERVAL%/$RELOAD_CONFIG_INTERVAL/g" server/gameserver/conf/gameserver.xml
sed -i "s/%RELOAD_CONFIG_INTERVAL%/$RELOAD_CONFIG_INTERVAL/g" server/gateserver/conf/gateserver.xml
sed -i "s/%RELOAD_CONFIG_INTERVAL%/$RELOAD_CONFIG_INTERVAL/g" server/muipserver/conf/muipserver.xml
sed -i "s/%RELOAD_CONFIG_INTERVAL%/$RELOAD_CONFIG_INTERVAL/g" server/multiserver/conf/multiserver.xml
sed -i "s/%RELOAD_CONFIG_INTERVAL%/$RELOAD_CONFIG_INTERVAL/g" server/nodeserver/conf/nodeserver.xml
sed -i "s/%RELOAD_CONFIG_INTERVAL%/$RELOAD_CONFIG_INTERVAL/g" server/oaserver/conf/oaserver.xml
sed -i "s/%RELOAD_CONFIG_INTERVAL%/$RELOAD_CONFIG_INTERVAL/g" server/pathfindingserver/conf/pathfindingserver.xml
sed -i "s/%RELOAD_CONFIG_INTERVAL%/$RELOAD_CONFIG_INTERVAL/g" server/tothemoonserver/conf/tothemoonserver.xml