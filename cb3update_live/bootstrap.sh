#!/bin/bash

if [ -f .bootstrap.lock ]; then
  echo 'Error: Installation already finished; please delete ".bootstrap.lock" file if you wish to re-run it; note that it will _destroy_ current data in database!' >&2
  exit 1
fi

if [ -f docker-compose.yml ]; then
  docker compose kill
  docker compose rm -f
fi

docker compose kill
docker compose rm
sudo rm -rf mysql redis

# Remove all unused networks. Unused networks are those which are not referenced by any containers
docker network prune -f

docker compose -f docker-preinstall.yml up preparevars
docker compose -f docker-preinstall.yml kill preparevars
docker compose -f docker-preinstall.yml rm -f preparevars

docker compose up -d mysql redis phpmyadmin adminer

docker compose -f docker-preinstall.yml up preparedb
docker compose -f docker-preinstall.yml kill preparedb
docker compose -f docker-preinstall.yml rm -f preparedb

touch .bootstrap.lock

docker compose down
docker compose up -d

echo 'Installation done. Servers starting...'
echo 'If you want start servers in the future - DONT use bootstrap.sh!'
echo 'Start it ONLY from Docker dashboard in Windows or using "docker compose up -d" in Linux/Windows/etc'
echo 'Have fun!'