#!/bin/sh

CODIS_HOME=/usr/local/codis
CODIS_DIR=/app/codis/6679

echo "shut down Redis_proxy73..."

$CODIS_HOME/bin/codis-config -c $CODIS_DIR/etc/config.ini proxy offline proxy_73

echo "done"

echo "start new Redis_proxy73..."

nohup $CODIS_HOME/bin/codis-proxy --log-level info -c $CODIS_DIR/etc/config.ini -L $CODIS_DIR/log/proxy_73.log  --cpu=8 --addr=0.0.0.0:19000 --http-addr=0.0.0.0:11000 > $CODIS_DIR/log/proxy_73.log & 

echo "done"

echo "sleep 3s"

sleep 3

tail -n 30 $CODIS_DIR/log/proxy_73.log

