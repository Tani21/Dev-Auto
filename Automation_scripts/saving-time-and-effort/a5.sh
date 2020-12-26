#! /usr/bin/bash

if [ -z "$1" ]
then
        echo "ERROR: Webserver port is not specified in the arguments" >&2
        exit 1;
fi

listening_port=$1
netstat -lnt | grep -q ":$1 "

if [[ $? != 0 ]]
then
        echo "ERROR: Web server is not running";
        /etc/init.d/apache2 restart
#       sudo service apache2 start
fi

path_to_script=$(realpath "$0")
if ! (crontab -l | grep -Fxq "*/1 * * * * $path_to_script $listening_port")
then
        crontab -l | { cat; echo "*/1 * * * * $path_to_script $listening_port"; } |
                crontab - echo "Script added to cron"
fi

exit 0
