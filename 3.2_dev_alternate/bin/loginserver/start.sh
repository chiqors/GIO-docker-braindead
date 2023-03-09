#!/bin/bash
cd /app
mkdir -p /var/cache/apt/archives/partial
apt-get autoclean
apt-get update
apt-get install libicu70 -y
./WebServer