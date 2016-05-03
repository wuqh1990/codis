#!/bin/bash
CONF_DIR=/app/codis/6679/log

PROXY_PID=`ps -ef | grep codis-proxy |grep -v grep|awk '{print $2}'`

if [ ! $PROXY_PID ]; then
	shutdown_tm=`date +%Y%m%d%H%M%S`
	echo $shutdown_tm::::"proxy_73 has been shutdown!" >>  $CONF_DIR/listener.log
	sh /app/codis/6679/bin/start_proxy.sh 
 	startup_tm=`date +%Y%m%d%H%M%S`
	echo $startup_tm::::"proxy_73  startup!" >>  $CONF_DIR/listener.log
else
	cur_tm=`date +%Y%m%d%H%M%S`
	echo $cur_tm::::"proxy_73 is alived" >>  $CONF_DIR/listener.log

fi
