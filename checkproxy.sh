#!/bin/sh

restartproxy()
{
    cd /root/codis/src/github.com/wandoulabs/codis 
    mv ./data/log/codis_proxy.log* bak
    nohup ./bin/codis-proxy -c config.ini -L ./data/log/codis_proxy.log --log-level=debug --addr=$(ifconfig eth0|awk -F"[ :]+" '/inet addr/{print $4}'):19001 --http-addr=$(ifconfig eth0|awk -F"[ :]+" '/inet addr/{print $4}'):11000 &
}

source /etc/profile
source /root/.bash_profile
_chvar=$(ps -ef | grep "/bin/codis-proxy" | grep -v grep)

if [[ "${_chvar}aa" == "aa" ]]
then
    restartproxy;
else
    cd /root/codis/src/github.com/wandoulabs/codis
    _chvar=$(cat ./data/log/codis_proxy.log* | tail -n 1 | grep "wait to be online")
    if [[ "${_chvar}aa" != "aa" ]]
    then
        #kill the proxy
        pid=$(ps -ef | grep "/bin/codis-proxy" | grep -v grep | awk '{print $2}')
        kill $pid
        restartproxy;
    fi
fi