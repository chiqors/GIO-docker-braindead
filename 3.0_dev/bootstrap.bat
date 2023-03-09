@echo off
if exist .bootstrap.lock (
echo Error: Installation already finished; please delete ".bootstrap.lock" file if you wish to re-run it; note that it will destroy current data in database!
pause
exit /b 1
)

if exist docker-compose.yml (
docker compose kill
docker compose rm -f
)

RD /S /Q mysql
RD /S /Q redis

REM Remove all unused networks. Unused networks are those which are not referenced by any containers
docker network prune -f

docker compose -f docker-preinstall.yml up preparevars
docker compose -f docker-preinstall.yml kill preparevars
docker compose -f docker-preinstall.yml rm -f preparevars

docker compose up -d mysql redis phpmyadmin adminer

docker compose -f docker-preinstall.yml up preparedb
docker compose -f docker-preinstall.yml kill preparedb
docker compose -f docker-preinstall.yml rm -f preparedb

echo. > .bootstrap.lock

docker compose down
docker compose up -d

echo Installation done. Servers starting...
echo If you want start servers in the future - DONT use bootstrap.sh!
echo Start it ONLY from Docker dashboard in Windows or using "docker compose up -d" in Linux/Windows/etc
echo Have fun!
pause